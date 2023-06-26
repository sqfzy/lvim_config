local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
return {
	s(
		"!",
		fmt(
			[[
#include <iostream>
#include <string>
#include <vector>

int main(int argc, char *argv[]) {{
  {}

  return EXIT_SUCCESS;
}}
	    ]],
			{
				i(1),
			}
		)
	),
	s({ trig = "FLT", dscr = "float.h中的宏" }, t("FLT_EPSILON")),
	s({ trig = "CLO", dscr = "time.h中的宏，表示一秒有多少个时钟计时单元" }, t("CLOCKS_PER_SEC")),
	-- 数组遍历
	s(
		{ trig = "afor([%w_]+)", regTrig = true, snippetType = "autosnippet" },
		fmt(
			[[
for (int {} = std::begin({}); {} < std::end({}); {}++) {{
  {}
}}
  ]],
			{
				d(1, function(_, snip)
					-- captures[1],获取正则()中的字符作为insert节点的文本
					return sn(1, t(snip.captures[1]))
				end),
				i(2, "arr"),
				rep(1),
				rep(2),
				rep(1),
				i(3),
			}
		)
	),
	-- vector遍历
	s(
		{ trig = "vfor([%w_]+)", regTrig = true, snippetType = "autosnippet" },
		fmt(
			[[
for (int {} = {}.begin(); {} < {}.end(); {}++) {{
  {}
}}
  ]],
			{
				d(1, function(_, snip)
					-- captures[1],获取正则()中的字符文本
					return sn(1, t(snip.captures[1]))
				end),
				i(2, "vec"),
				rep(1),
				rep(2),
				rep(1),
				i(3),
			}
		)
	),
	-- 迭代器
	s(
		{ trig = "efor", snippetType = "autosnippet" },
		fmt(
			[[
for(auto {} : {}) {{
  {}  
}}
  ]],
			{
				c(1, { i(1, "var"), i(2, "&var") }),
				i(2, "collection_to_loop"),
				i(3),
			}
		)
	),
	s(
		{ trig = "ffor([%w_]+)", regTrig = true, snippetType = "autosnippet" },
		fmt(
			[[
	for (int {} = 0; {} < {}; {}++) {{
	  {}
	}}
	  ]],
			{
				d(1, function(_, snip)
					-- captures[1],获取正则()中的字符作为insert节点的文本
					return sn(1, t(snip.captures[1]))
				end),
				rep(1),
				i(2, "len"),
				rep(1),
				i(3),
			}
		)
	),
	-- 自动补std::
	s({ trig = "couts", snippetType = "autosnippet" }, t("std::cout")),
	s({ trig = "endls", snippetType = "autosnippet" }, t("std::endl")),
	s({ trig = "cins", snippetType = "autosnippet" }, t("std::cin")),
	-- s({ trig = "cerrs", snippetType = "autosnippet" }, t("std::cerr")),
	-- s({ trig = "strings", snippetType = "autosnippet" }, t("std::string")),
	-- s({ trig = "vecs", snippetType = "autosnippet" }, {
	-- 	t("std::vector<"),
	-- 	i(1),
	-- 	t("> "),
	-- 	i(2),
	-- }),
	-- s({ trig = "fstreams", snippetType = "autosnippet" }, t("std::fstream ")),
	-- s({ trig = "ifstreams", describe = "只允许in模式", snippetType = "autosnippet" }, t("std::ifstream")),
	-- s({ trig = "ofstreams", describe = "只允许out模式", snippetType = "autosnippet" }, t("std::ofstream")),
	-- s({ trig = "istreams", snippetType = "autosnippet" }, t("std::istream")),
	-- s({ trig = "ostreams", snippetType = "autosnippet" }, t("std::ostream")),
	-- s(
	-- 	{ trig = "!iobit", describe = "using流的条件状态" },
	-- 	{ t("using std::ios::badbit"), t("std::ios::eofbit"), t("std::ios::failbit"), t("std::ios::goodbit") }
	-- ),

	s({ trig = "badbit", describe = "系统级错误，读写设备失败，0001" }, t("std::ios::badbit")),
	s({ trig = "eofbit", describe = "达到文件末尾，0010" }, t("std::ios::eofbit")),
	s({ trig = "failbit", describe = "读写失败(包含bad和eof)，0100" }, t("std::ios::failbit")),
	s({ trig = "goodbit", describe = "流处于有效状态，0000" }, t("std::ios::goodbit")),
	s({ trig = "in::i", describe = "只读" }, t("std::ios::in")),
	s({ trig = "out::o", describe = "只写,默认带有trunc" }, t("std::ios::out")),
	s({ trig = "trunc::o", describe = "截断文件,必须(隐)含有out" }, t("std::ios::trunc")),
	s(
		{ trig = "app::o", describe = "每次执行写操作时定位到文件尾,不能含有trunc,自带out" },
		t("std::ios::app")
	),
	s({ trig = "ate::io", describe = "打开文件后定位到末尾" }, t("std::ios::trunc")),
	s({ trig = "binary::i", describe = "二进制模式读" }, t("std::ios::binary | std::ios::in")),
	s({ trig = "binaru::o", describe = "二进制模式写" }, t("std::ios::binary | std::ios::out")),

	-- 注释// -> /* */
	s(
		{ trig = "///", snippetType = "autosnippet" },
		sn(1, {
			t("/* "),
			i(1),
			t(" */"),
		})
	),
	s(
		{ trig = "// /", snippetType = "autosnippet" },
		sn(1, {
			t("/* "),
			i(1),
			t(" */"),
		})
	),
	-- debug
	s("debug", t('std::cout << "debug" << std::endl;')),
}
