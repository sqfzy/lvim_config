-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
package.path = package.path .. ";/home/kali/.config/lvim/?.lua"
local keymap = require("keymappings")
keymap.set_lunsnip_keymaps()
keymap.set_multi_keymaps()

-- require("autocmds")
require("options")
require("plugins")
require("colorscheme")
require("lsp.null-ls")
require("lsp.lsp_config")

require("plugins_config.lunsnip")



