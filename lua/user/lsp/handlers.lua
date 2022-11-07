local M = {}

local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.formatting = { format_on_save = { enabled = true } }
if type(M.formatting.format_on_save) == "boolean" then
  M.formatting.format_on_save = { enabled = M.formatting.format_on_save }
end

M.format_opts = vim.deepcopy(M.formatting)
M.format_opts.disabled = nil
M.format_opts.format_on_save = nil
M.format_opts.filter = function(client)
  local filter = M.formatting.filter
  local disabled = M.formatting.disabled or {}
  -- check if client is fully disabled or filtered by function
  return not (vim.tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
  local capabilities = M.capabilities
  local lsp_mappings = {
    n = {
      ["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
      ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
      ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
    },
    v = {},
  }

  lsp_mappings.n["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" }
  lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]

  lsp_mappings.n["gD"] = { function() vim.lsp.buf.declaration() end, desc = "Declaration of current symbol" }

  lsp_mappings.n["gd"] = { function() vim.lsp.buf.definition() end, desc = "Show the definition of current symbol" }
  lsp_mappings.n["<leader>lf"] = {
    function() vim.lsp.buf.format(M.format_opts) end,
    desc = "Format code",
  }
  lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function() vim.lsp.buf.format(M.format_opts) end,
    { desc = "Format file with LSP" }
  )
  local autoformat = M.formatting.format_on_save
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if
    autoformat.enabled
    and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
    and (tbl_isempty(autoformat.ignore_filetypes or {}) or not tbl_contains(autoformat.ignore_filetypes, filetype))
  then
    local autocmd_group = "auto_format_" .. bufnr
    vim.api.nvim_create_augroup(autocmd_group, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = autocmd_group,
      buffer = bufnr,
      desc = "Auto format buffer " .. bufnr .. " before save",
      callback = function()
        if vim.g.autoformat_enabled then
          vim.lsp.buf.format(utils.default_tbl({ bufnr = bufnr }, M.format_opts))
        end
      end,
    })
  end

  local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
  vim.api.nvim_create_augroup(highlight_name, {})
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = highlight_name,
    buffer = bufnr,
    callback = function() vim.lsp.buf.document_highlight() end,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = highlight_name,
    buffer = bufnr,
    callback = function() vim.lsp.buf.clear_references() end,
  })

  lsp_mappings.n["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" }

  lsp_mappings.n["gI"] = { function() vim.lsp.buf.implementation() end, desc = "Implementation of current symbol" }

  lsp_mappings.n["gr"] = { function() vim.lsp.buf.references() end, desc = "References of current symbol" }

  lsp_mappings.n["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" }

  lsp_mappings.n["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" }

  lsp_mappings.n["gT"] = { function() vim.lsp.buf.type_definition() end, desc = "Definition of current type" }

  utils.set_mappings(lsp_mappings, { buffer = bufnr })
  if not vim.tbl_isempty(lsp_mappings.v) then
    utils.which_key_register({ v = { ["<leader>"] = { l = { name = "LSP" } } } }, { buffer = bufnr })
  end
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
