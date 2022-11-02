local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason.packer.nvim",
    install_path
  }
  print "Installing packer close and reopen neovim"
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reload neovim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use protected call so it doesn't throw on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  }
})

-- List of plugins to install
return packer.startup(function(use)
  -- Misc
  use "wbthomason/packer.nvim"          -- Have packer manage itself
  use "nvim-lua/popup.nvim"             -- An implementation of the Popup API from vim to neovim
  use "nvim-lua/plenary.nvim"           -- Useful lua functions used by lots of plugins
  use "nvim-tree/nvim-web-devicons"
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "goolord/alpha-nvim"
  use "akinsho/bufferline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "lewis6991/impatient.nvim"
  use "akinsho/toggleterm.nvim"
  use "moll/vim-bbye"
  use "lukas-reineke/indent-blankline.nvim"
  use "Shatur/neovim-session-manager"

  -- Colorschemes
  use "Mofiqul/dracula.nvim"
  use "wadackel/vim-dogrun"
  use "sainnhe/everforest"
  use "folke/tokyonight.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"                -- The completion plugin
  use "hrsh7th/cmp-nvim-lsp"            -- lsp completions
  use "hrsh7th/cmp-nvim-lua"            -- lua completions
  use "hrsh7th/cmp-buffer"              -- buffer completions
  use "hrsh7th/cmp-path"                -- path completions
  use "hrsh7th/cmp-cmdline"             -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"        -- snippet completions

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "ahmedkhalf/project.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"

  -- Snippets
  use "L3MON4D3/LuaSnip"                -- snippet engine
  use "rafamadriz/friendly-snippets"    -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- SchemaStore
  use "b0o/schemastore.nvim"

  -- Rust
  use "simrat39/rust-tools.nvim"

  -- Which key
  use "folke/which-key.nvim"
  
  if PACKER_BOOSTRAP then
    require("packer").sync()
  end

end)
