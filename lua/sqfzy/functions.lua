_G.sqfzy = {}

function _G.sqfzy.map(mod, key, keymap)
	local map = vim.api.nvim_set_keymap
	local opt = { noremap = true, silent = true }
	map(mod, key, keymap)
end

-- 返回光标上的字符
function _G.sqfzy.get_cursor_char()
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local cursor_char = string.sub(line, col, col)
	return cursor_char
end

-------------------------------- require -----------------------------------------
local function _assign(old, new, k)
	local otype = type(old[k])
	local ntype = type(new[k])
	if (otype == "thread" or otype == "userdata") or (ntype == "thread" or ntype == "userdata") then
		vim.notify(string.format("warning: old or new attr %s type be thread or userdata", k))
	end
	old[k] = new[k]
end

local function _replace(old, new, repeat_tbl)
	if repeat_tbl[old] then
		return
	end
	repeat_tbl[old] = true

	local dellist = {}
	for k, _ in pairs(old) do
		if not new[k] then
			table.insert(dellist, k)
		end
	end
	for _, v in ipairs(dellist) do
		old[v] = nil
	end

	for k, _ in pairs(new) do
		if not old[k] then
			old[k] = new[k]
		else
			if type(old[k]) ~= type(new[k]) then
				_assign(old, new, k)
			else
				if type(old[k]) == "table" then
					_replace(old[k], new[k], repeat_tbl)
				else
					_assign(old, new, k)
				end
			end
		end
	end
end

-- 清除require
_G.sqfzy.require_clean = function(m)
	package.loaded[m] = nil
	_G[m] = nil
	local _, module = pcall(require, m)
	return module
end

_G.sqfzy.require_safe = function(mod)
	local status_ok, module = pcall(require, mod)
	if not status_ok then
		local trace = debug.getinfo(2, "SL")
		local shorter_src = trace.short_src
		local lineinfo = shorter_src .. ":" .. (trace.currentline or trace.linedefined)
		local msg = string.format("%s : skipped loading [%s]", lineinfo, mod)
	end
	return module
end

_G.sqfzy.reload = function(mod)
	if not package.loaded[mod] then
		return _G.sqfzy.require_safe(mod)
	end

	local old = package.loaded[mod]
	package.loaded[mod] = nil
	local new = _G.sqfzy.require_safe(mod)

	if type(old) == "table" and type(new) == "table" then
		local repeat_tbl = {}
		_replace(old, new, repeat_tbl)
	end

	package.loaded[mod] = old
	return old
end

-- code from <https://github.com/tjdevries/lazy-require.nvim/blob/bb626818ebc175b8c595846925fd96902b1ce02b/lua/lazy-require.lua#L25>
function _G.sqfzy.require_on_index(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(require_path)[key]
		end,

		__newindex = function(_, key, value)
			require(require_path)[key] = value
		end,
	})
end

-- code from <https://github.com/tjdevries/lazy-require.nvim/blob/bb626818ebc175b8c595846925fd96902b1ce02b/lua/lazy-require.lua#L25>
function _G.sqfzy.require_on_exported_call(require_path)
	return setmetatable({}, {
		__index = function(_, k)
			return function(...)
				return require(require_path)[k](...)
			end
		end,
	})
end

-- function _G.ReloadConfig()
-- 	for name, _ in pairs(package.loaded) do
-- 		print(name, _)
-- 		if name:match("nvim") then
-- 			package.loaded[name] = nil
-- 		end
-- 	end

-- 	-- dofile("../init.lua")
-- end

-- vim.api.nvim_set_keymap("n", "<Leader>vs", "<Cmd>lua ReloadConfig()<CR>", { silent = true, noremap = true })
-- vim.cmd("command! ReloadConfig lua ReloadConfig()")

_G.sqfzy.lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

return sqfzy
