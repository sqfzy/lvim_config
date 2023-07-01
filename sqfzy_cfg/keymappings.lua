local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-------------------------------  normal ---------------------------------------------
lvim.keys.normal_mode = {
	-- Better window movement
	["<C-h>"] = "<C-w>h",
	["<C-j>"] = "<C-w>j",
	["<C-k>"] = "<C-w>k",
	["<C-l>"] = "<C-w>l",
	-- ["<C-w>"] = "<C-w>w",

	-- Resize with arrows
	["<C-Up>"] = ":resize -2<CR>",
	["<C-Down>"] = ":resize +2<CR>",
	["<C-Left>"] = ":vertical resize -2<CR>",
	["<C-Right>"] = ":vertical resize +2<CR>",

	-- Move current line / block with Alt-j/k a la vscode.
	["<A-j>"] = ":m .+1<CR>==",
	["<A-k>"] = ":m .-2<CR>==",

	-- QuickFix
	["]q"] = ":cnext<CR>",
	["[q"] = ":cprev<CR>",
	["<C-q>"] = ":call QuickFixToggle()<CR>",

	["<Esc>"] = "",
	["L"] = "$",
	["H"] = "^",
	["c"] = '"dc',
	["s"] = '"ds',
	["<C-d>"] = "10j",
	["<C-u>"] = "10k",
	["<C-a>"] = "gg^vG$",
	["<A-a>"] = "<C-a>", --值加1
	["<A-d>"] = "<C-x>", --值减1
	-- ["<C-n>"] = "&", --重复替换操作
	["yw"] = "byw", -- 复制单词
	["ty"] = '"ty',
	["yib"] = "yi(",
	["yis"] = 'yi"',
	["yii"] = "yi{",
	["tp"] = '"tp',
	["X"] = "dd", --剪切一行
	-- ["<C-x>"] = '"+dw', --剪切单词
	["d"] = '"_d', --删除
	["D"] = '"_D',
	["dL"] = '"_d$',
	["dH"] = '"_d^',
	["E"] = "ea<Space>",
	["B"] = "bi<Space><Left>",
	["mj"] = "mJ",
	["mk"] = "mK",
	["gj"] = "`J",
	["gk"] = "`K",
	-- 折叠
	["zh"] = "zfi{",
	["zl"] = "zo",
	-- 标签页
	["<A-l>"] = ":BufferLineCycleNext<CR>",
	["<A-h>"] = ":BufferLineCyclePrev<CR>",
	["<A-c>"] = "<cmd>BufferKill<cr>",
	["<A-o>"] = "<C-^>", -- 在两个最近的标签页间跳转
	["<A-v>"] = ":vs<CR>",
	["<A-x>"] = ":sp<CR>", --m == alt ()
	-- 添加，替换，搜索
	["<A-;>"] = "$a;<ESC>", --句尾添';'
	["<A-,>"] = "$a,<ESC>", --句尾添','
	["<A-s>"] = 'bi"<ESC>ea"<ESC>',
	["<A-i>"] = "bi{<ESC>ea}<ESC>",
	["<A-'>"] = "bi'<ESC>ea'<ESC>",
	["<A-9>"] = "bi(<ESC>ea)<ESC>",
	["<A-[>"] = "bi[<ESC>ea]<ESC>",
	["cb"] = '"_cib', --()
	["ci"] = '"_ciB', --{}
	["cw"] = '"_ciw', --单词
	["cs"] = '"_ci"', --字符串
	["c'"] = "\"_ci'", -- ''
	["c["] = '"_ci[', -- []
	["c,"] = '"_ci<', -- <>
	["db"] = '"tyi(da(h"tp',
	["d9"] = '"tyi(da(h"tp',
	["ds"] = '"tyi"da"h"tp',
	["d["] = '"tyi[da[h"tp',
	["di"] = '"tyi{da{h"tp',
	["<BS>"] = 'mt%"_x`ta<BS><Space><Esc>',
	["<A-f>"] = "/<C-r>+<CR>", --搜寻复制内容
	[";"] = "n",
	[","] = "N",
	[">"] = ">>",
	["<"] = "<<",
}

-------------------------------  insert ---------------------------------------------
lvim.keys.insert_mode = {
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-j>"] = "<Esc>:m .+1<CR>==gi",
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-k>"] = "<Esc>:m .-2<CR>==gi",
	-- navigation
	["<A-Up>"] = "<C-\\><C-N><C-w>k",
	["<A-Down>"] = "<C-\\><C-N><C-w>j",
	["<A-Left>"] = "<C-\\><C-N><C-w>h",
	["<A-Right>"] = "<C-\\><C-N><C-w>l",

	["jj"] = "<ESC>",
	["jk"] = "<ESC>",
	["<A-;>"] = "<ESC>$a;", --句尾添';'
	["<A-s>"] = '<ESC>bi"<ESC>ea"',
	["<A-i>"] = "<ESC>bi{<ESC>ea}",
	["<A-9>"] = "<ESC>bi(<ESC>ea)",
	["<A-'>"] = "<ESC>bi'<ESC>ea'",
	["<A-[>"] = "<ESC>bi[<ESC>ea]",
	["<A-,>"] = "<ESC>bi<<ESC>ea>",
	["<A-->"] = "->",
	["<A-=>"] = "=>",
	-- ["<Tab>"] = "<Right>",
	-- ["<S-Tab>"] = "<Left>",
	["<S-Right>"] = "<Left>",

	["<S-l><S-l>"] = "<Esc><S-a>",
	["<S-h><S-h>"] = "<Esc><S-i>",

	["<C-h>"] = "<Esc>gh",
	["<C-l>"] = "<Esc>lgh",
}

-------------------------------  visual ---------------------------------------------
local visual_mode = {
	-- Better indenting
	["<"] = "<gv",
	[">"] = ">gv",
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",

	["H"] = "^",
	["L"] = "$",
	["<C-a>"] = "<ESC>gg", --取消全选
	["<A-a>"] = "<C-a>",
	["ty"] = '"ty',
	["X"] = "D", --剪切一行
	["d"] = '"_d', --删除
	["D"] = '"_D',
	["p"] = '"_dP', -- 粘贴后不会复制被粘贴的文本
	["tp"] = '"_d"tP',
	["zh"] = "zf",
	["<A-s>"] = '"-xi""<Esc>"-P',
	["<A-i>"] = '"-xi{}<Esc>"-P',
	["<A-'>"] = "\"-xi''<Esc>\"-P",
	["<A-b>"] = '"-xi()<Esc>"-P',
	["<A-[>"] = '"-xi[]<Esc>"-P',
	["<A-,>"] = '"-xi<><Esc>"-P',
}
for k, v in pairs(visual_mode) do
	map("v", k, v, opts)
end

-------------------------------  visual-block ---------------------------------------------
lvim.keys.visual_block_mode = {
	-- Move current line / block with Alt-j/k ala vscode.
	["<A-j>"] = ":m '>+1<CR>gv-gv",
	["<A-k>"] = ":m '<-2<CR>gv-gv",
}

-- -------------------------------  term ---------------------------------------------
local term_mode = {
	-- Terminal window navigation
	["<C-h>"] = "<C-\\><C-N><C-w>h",
	["<C-j>"] = "<C-\\><C-N><C-w>j",
	["<C-k>"] = "<C-\\><C-N><C-w>k",
	["<C-l>"] = "<C-\\><C-N><C-w>l",
}
for k, v in pairs(term_mode) do
	map("t", k, v, opts)
end

-------------------------------  select ---------------------------------------------
local select_mode = {
	["p"] = "p",
	["d"] = "d",
	["D"] = "D",
	["<BS>"] = "<BS>i",
	["<C-l>"] = "<Right>",
	["<C-h>"] = "<Left>",
}
for k, v in pairs(select_mode) do
	map("s", k, v, opts)
end

---------------------------------------------------------------------
----------------------------- Plugins ----------------------------------
---------------------------------------------------------------------
local pluginKeys = {}

-------------------------------  lunsnip快捷键  ---------------------------------------------
pluginKeys.set_lunsnip_keymaps = function()
	--切换补全
	map("i", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("s", "<A-n>", "<Plug>luasnip-next-choice", opts)
	map("i", "<A-p>", "<Plug>luasnip-prev-choice", opts)
	map("s", "<A-p>", "<Plug>luasnip-prev-choice", opts)
	map("i", "<A-h>", "<cmd>lua require('luasnip').jump(-1)<Cr>", opts)
	map("s", "<A-h>", "<cmd>lua require('luasnip').jump(-1)<Cr>", opts)
	map("i", "<A-l>", "<cmd>lua require('luasnip').jump(1)<Cr>", opts)
	map("s", "<A-l>", "<cmd>lua require('luasnip').jump(1)<Cr>", opts)
end

-------------------------------  leap  ---------------------------------------------
pluginKeys.set_leap_keymaps = function()
	map("n", "f", "<Plug>(leap-forward-to)", opts)
	map("n", "F", "<Plug>(leap-backward-to)", opts)
	map("n", "s", "<Plug>(leap-forward-till)", opts)
	map("n", "S", "<Plug>(leap-backward-till)", opts)
	map("n", "<C-f>", "<Plug>(leap-from-window)", opts)
end

-------------------------------  vim-mul  ---------------------------------------------
vim.g.VM_default_mappings = 0
pluginKeys.set_multi_keymaps = function()
	vim.g.VM_maps = {}
	vim.g.VM_maps = {
		["Remove Region"] = "<C-p>",
		["Select All"] = "<C-A-n>",
	}
end

-------------------------------  cmp  ---------------------------------------------
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.mapping["<Tab>"] = require("cmp").mapping.confirm({ select = true })

-------------------------------  cmp  ---------------------------------------------
pluginKeys.outline_keymaps = {
	close = { "<Esc>", "q" },
	goto_location = "<Cr>",
	focus_location = "o",
	hover_symbol = "K",
	toggle_preview = "t",
	rename_symbol = "r",
	code_actions = "a",
	fold = "h",
	unfold = "l",
	fold_all = "W",
	unfold_all = "E",
	fold_reset = "R",
}

-------------------------------  which_key  ---------------------------------------------
local wk = lvim.builtin.which_key.mappings
wk["w"] = { "<cmd>lua vim.lsp.buf.format()<cr><cmd>w!<cr>", "Save with format" }
wk["W"] = { "<cmd>w!<cr>", "Save" }
wk["j"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" }
wk["k"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" }
wk["z"] = { "<cmd>ZenMode<CR>", "ZenMode" }
wk["o"] = { "<cmd>SymbolsOutline<CR>", "Outline" }
wk["c"] = {
	name = "Copilot",
	{
		e = { "<cmd>Copilot disable<CR>", "Copilot disable" },
		b = { "<cmd>Copilot enable<CR>", "Copilot enable" },
		E = { "<cmd>lua require('copilot.suggestion').dismiss()<cr>", "Copilot dismiss" },
	},
}
wk["S"] = {
	name = "Sqfzy",
	c = { "<cmd>edit $HOME/code_my/code_my.txt<cr>", "My code" },
	i = { "<cmd>edit $HOME/AppData/Local/lvim/sqfzy_cfg/sqfzy_init.lua<cr>", "Edit init.lua" },
	k = { "<cmd>edit $HOME/AppData/Local/lvim/sqfzy_cfg/keymappings.lua<cr>", "Edit keymappings.lua" },
	o = { "<cmd>edit $HOME/AppData/Local/lvim/sqfzy_cfg/options.lua<cr>", "Edit options.lua" },
	p = { "<cmd>edit $HOME/AppData/Local/lvim/sqfzy_cfg/plugins.lua<cr>", "Edit plugins.lua" },
	n = { "<cmd>edit $HOME/AppData/Local/lvim/sqfzy_cfg/lsp/null-ls.lua<cr>", "Edit null-ls.lua" },
}
wk["l"]["m"] = { "<cmd>Mason<cr>", "Mason" }
wk["l"]["f"] = nil
wk["F"] = {
	function()
		require("lvim.core.telescope.custom-finders").find_project_files({ previewer = false })
	end,
	"Find File",
}
wk["f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" }

return pluginKeys
