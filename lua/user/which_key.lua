local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.setup {
  active = true,
  plugins = {
    spelling = { enable = true },
    presets = { operators = false },
  },
  icons = {
    breadcrumb = "» ", -- symbol used in the command line area that shows your active key combo
    separator = " ", -- symbol used between a key and it's label
    group = " ", -- symbol prepended to a group
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  show_help = true, -- show help message on the command line when the popup is visible
}


