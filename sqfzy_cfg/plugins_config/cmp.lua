local cmp_mapping = require("cmp.config.mapping")
local methods = require("lvim.core.cmp").methods

lvim.builtin.cmp.mapping["<Tab>"] = nil
lvim.builtin.cmp.mapping["<S-Tab>"] = nil
lvim.builtin.cmp.mapping["<C-Space>"] = nil
lvim.builtin.cmp.on_config_done = function(cmp)
	cmp_mapping(function(fallback)
		if methods.has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" })
end
