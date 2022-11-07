local is_available = utils.is_available

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

local maps = {
  i = {},
  n = {},
  v = {},
  t = {},
  [""] = {}
}

maps[""]["<Space>"] = "<Nop>"

-- Standard operations --
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" }
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }
maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
maps.n["<leader>q"] = { "<cmd>lua require 'user.utils.functions.smart_quit()<cr>", desc = "Smart quit" }
maps.n["Q"] = "<Nop>"

-- Packer
maps.n["<leader>pc"] = { "<cmd>PackerCompile<cr>", desc = "Packer Compile" }
maps.n["<leader>pi"] = { "<cmd>PackerInstall<cr>", desc = "Packer Install" }
maps.n["<leader>ps"] = { "<cmd>PackerSync<cr>", desc = "Packer Sync" }
maps.n["<leader>pS"] = { "<cmd>PackerStatus<cr>", desc = "Packer Status" }
maps.n["<leader>pu"] = { "<cmd>PackerUpdate<cr>", desc = "Packer Update" }

-- Alpha
  maps.n["<leader>d"] = { function() require("alpha").start() end, desc = "Dashboard" }

-- Bufdelete
  maps.n["<leader>c"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Close buffer" }
  maps.n["<leader>C"] = { function() require("bufdelete").bufdelete(0, true) end, desc = "Force close buffer" }

-- Navigate buffers
  maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" }
  maps.n[">b"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" }
  maps.n["<b"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" }


-- Comment
  maps.n["<leader>/"] = { function() require("Comment.api").toggle.linewise.current() end, desc = "Comment line" }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment line",
  }

-- GitSigns
  maps.n["<leader>gj"] = { function() require("gitsigns").next_hunk() end, desc = "Next git hunk" }
  maps.n["<leader>gk"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" }
  maps.n["<leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View git blame" }
  maps.n["<leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview git hunk" }
  maps.n["<leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset git hunk" }
  maps.n["<leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset git buffer" }
  maps.n["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage git hunk" }
  maps.n["<leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage git hunk" }
  maps.n["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View git diff" }

-- NerdTree
  maps.n["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>o"] = { "<cmd>NvimTreeFocus<cr>", desc = "Focus Explorer" }

-- Session Manager
  maps.n["<leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
  maps.n["<leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
  maps.n["<leader>Sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
  maps.n["<leader>S."] =
    { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }

-- Package Manager
maps.n["<leader>pI"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
maps.n["<leader>pU"] = { "<cmd>MasonToolsUpdate<cr>", desc = "Mason Updater" }

-- Smart Splits
  -- Better window navigation
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }

  -- Resize with arrows
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }

-- Telescope
  maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Search words" }
  maps.n["<leader>fW"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      }
    end,
    desc = "Search words in all files",
  }
  maps.n["<leader>gt"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" }
  maps.n["<leader>gb"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
  maps.n["<leader>gc"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" }
  maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Search files" }
  maps.n["<leader>fF"] = {
    function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
    desc = "Search all files",
  }
  maps.n["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Search buffers" }
  maps.n["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Search help" }
  maps.n["<leader>fm"] = { function() require("telescope.builtin").marks() end, desc = "Search marks" }
  maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Search history" }
  maps.n["<leader>fc"] =
    { function() require("telescope.builtin").grep_string() end, desc = "Search for word under cursor" }
  maps.n["<leader>sb"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
  maps.n["<leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Search help" }
  maps.n["<leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Search man" }
  maps.n["<leader>sn"] =
    { function() require("telescope").extensions.notify.notify() end, desc = "Search notifications" }
  maps.n["<leader>sr"] = { function() require("telescope.builtin").registers() end, desc = "Search registers" }
  maps.n["<leader>sk"] = { function() require("telescope.builtin").keymaps() end, desc = "Search keymaps" }
  maps.n["<leader>sc"] = { function() require("telescope.builtin").commands() end, desc = "Search commands" }
  maps.n["<leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope.nvim").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }
  maps.n["<leader>lG"] =
    { function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Search workspace symbols" }
  maps.n["<leader>lR"] = { function() require("telescope.builtin").lsp_references() end, desc = "Search references" }
  maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }

-- Terminal
  maps.n["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit float" }
  maps.n["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
  maps.n["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
  maps.n["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
  maps.n["<leader>tt"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "unindent line" }
maps.v[">"] = { ">gv", desc = "indent line" }

-- Improved Terminal Navigation
maps.t["<C-h>"] = { "<c-\\><c-n><c-w>h", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<c-\\><c-n><c-w>j", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<c-\\><c-n><c-w>k", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<c-\\><c-n><c-w>l", desc = "Terminal right window navigation" }

utils.set_mappings(maps, { silent = true, noremap = true })
