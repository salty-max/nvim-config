local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "dockerfile",
    "scss",
    "lua",
    "markdown",
    "markdown_inline",
    "bash",
    "rust",
    "typescript",
    "javascript",
    "html",
    "css",
    "go",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "python",
    "make",
    "cmake",
    "ninja",
    "tsx",
  },
  ignore_install = { "" },
  sync_install = false,

  highlight = {
    enable = true,
    disable = { "css" },
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python", "css", "yaml", "dockerfile" }
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
