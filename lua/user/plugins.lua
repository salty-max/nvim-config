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
return packer.startup(function()
  -- Misc
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }
  use "nvim-tree/nvim-web-devicons"

  -- Colorschemes
  use "Mofiqul/dracula.nvim"
  use "wadackel/vim-dogrun"

  -- Git
  use "lewis6991/gitsigns.nvim"
  
  if PACKER_BOOSTRAP then
    require("packer").sync()
  end

end)
