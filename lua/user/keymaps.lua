-- Shorten function name
local keymap = vim.api.nvim_set_keymap
-- Silent keymap option
local opts = { noremap = true, silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

-- Normal --

-- Misc
keymap("n", "<leader>fn", "<cmd>:ene!<cr>", opts)
keymap("n", "<leader>w", "<cmd>:w!<cr>", opts)
keymap("n", "<leader>q", "<cmd>lua require 'user.utils.functions'.smart_quit()<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)
-- Close current buffer
keymap("n", "<leader>c", "<cmd>:Bdelete!<cr>", opts)
-- Close buffers
keymap("n", "<S-q>", "<cmd>:Bdelete!<cr>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<cr>==", opts)
keymap("v", "<A-k>", ":m .-1<cr>==", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Plugins --

-- Packer
keymap("n", "<leader>pc", "<cmd>PackerCompile<cr>", opts)
keymap("n", "<leader>pi", "<cmd>PackerInstall<cr>", opts)
keymap("n", "<leader>ps", "<cmd>PackerSync<cr>", opts)
keymap("n", "<leader>pS", "<cmd>PackerStatus<cr>", opts)
keymap("n", "<leader>pu", "<cmd>PackerUpdate<cr>", opts)

-- Mason
keymap("n", "<leader>pI", "<cmd>Mason<cr>", opts)
keymap("n", "<leader>pU", "<cmd>MasonToolsUpdate<cr>", opts)

-- Sessions
keymap("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", opts)
keymap("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", opts)
keymap("n", "<leader>Sd", "<cmd>SessionManager! delete_session<cr>", opts)
keymap("n", "<leader>Sf", "<cmd>SessionManager! load_session<cr>", opts)
keymap("n", "<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>o", ":NvimTreeFocus<cr>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fF", "<cmd>lua require 'telescope.builtin'.find_files({ hidden = true, no_ignore = true })<cr>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>fp", ":Telescope projects<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<cr>", opts)
keymap("n", "<leader>ls", ":Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lG", ":Telescope lsp_workspace_symbols<cr>", opts)
keymap("n", "<leader>gb", ":Telescope git_branches<cr>", opts)
keymap("n", "<leader>gc", ":Telescope git_commits<cr>", opts)
keymap("n", "<leader>gs", ":Telescope git_status<cr>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)
keymap("n", "<leader>gj", "<cmd>lua require('gitsigns').next_hunk()<cr>", opts)
keymap("n", "<leader>gk", "<cmd>lua require('gitsigns').previous_hunk()<cr>", opts)
keymap("n", "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", opts)
keymap("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", opts)
keymap("n", "<leader>gh", "<cmd>lua require('gitsigns').reset_hunk()<cr>", opts)
keymap("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_buffer()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", opts)
keymap("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", opts)
keymap("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<cr>", opts)


-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("v", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>', opts)

-- Terminal
keymap("n", "<leader>tn", ":ToggleTerm node<cr>", opts)
keymap("n", "<leader>tf", ":ToggleTerm direction=float<cr>", opts)
keymap("n", "<leader>th", ":ToggleTerm size=10 direction=horizontal<cr>", opts)
keymap("n", "<leader>tv", ":ToggleTerm size=80 direction=vertical<cr>", opts)

-- Alpha
keymap("n", "<leader>h", "<cmd>Alpha<cr>", opts)
