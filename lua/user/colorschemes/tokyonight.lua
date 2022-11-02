local t_status_ok, tokyonight = pcall(require, "tokyonight")
if not t_status_ok then
  return
end

tokyonight.setup({
  style = "moon",
  terminal_colors = true,
})

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
