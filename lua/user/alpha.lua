local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
[[ _        _______  _______          _________ _______]],
[[( (    /|(  ____ \(  ___  )|\     /|\__   __/(       )]],
[[|  \  ( || (    \/| (   ) || )   ( |   ) (   | () () |]],
[[|   \ | || (__    | |   | || |   | |   | |   | || || |]],
[[| (\ \) ||  __)   | |   | |( (   ) )   | |   | |(_)| |]],
[[| | \   || (      | |   | | \ \_/ /    | |   | |   | |]],
[[| )  \  || (____/\| (___) |  \   /  ___) (___| )   ( |]],
[[|/    )_)(_______/(_______)   \_/   \_______/|/     \|]],
[[                                                      ]],
}
dashboard.section.buttons.val = {
  dashboard.button("f", "" .. "   Find File", "<cmd>Telescope find_files<cr>"),
  dashboard.button("e", "" .. "   New file", "<cmd>ene!<cr>"),
  dashboard.button("p", "" .. "   Project", "<cmd>lua require('telescope').extensions.projects.projects()<cr>"),
  dashboard.button("r", "" .. "   Recents", "<cmd>Telescope oldfiles <cr>"),
  dashboard.button("t", "" .. "   Find Word", "<cmd>Telescope live_grep <cr>"),
  dashboard.button("Sl", "" .. "   Last Session", "<cmd>SessionManager! load_last_session<cr>"),
  dashboard.button("c", "" .. "   Config", "<cmd>e $MYVIMRC <cr>"),
  dashboard.button("q", "" .. "   Quit", "<cmd>qa<cr>"),
}
local function footer()
  return "Maxime <salty_max> Blanc"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
