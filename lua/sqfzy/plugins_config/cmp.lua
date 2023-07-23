local lv_cmp = lvim.builtin.cmp
local cmp_mapping = require("cmp.config.mapping")
local methods = require("lvim.core.cmp").methods

lv_cmp["<S-Tab>"] = nil
lv_cmp["<C-Space>"] = nil
lv_cmp.on_config_done = function(cmp)
	lv_cmp["<Tab>"] = cmp_mapping(function(fallback)
		if methods.has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" })
end
