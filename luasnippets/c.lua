return {
	s("!", {
		t({ "#include <stdio.h>" }),
		t({ "", "#include <stdlib.h>" }),
		t({ "", "", "int main(int argc, char *argv[]) {" }),
		t({ "", "  " }),
		i(1), -- 在此处开始写,顺序为1,2,3...n,0
		t({ "", "", "  return EXIT_SUCCESS;" }),
		t({ "", "}" }),
	}),
	s(
		{ trig = "SEEK", dscr = "fwrite()的第三个参数" },
		c(1, {
			t("SEEK_SET"),
			t("SEEK_CUR"),
			t("SEEK_END"),
		})
	),
	s({ trig = "FLT", dscr = "float.h中的宏" }, t("FLT_EPSILON")),
	s({ trig = "CLO", dscr = "time.h中的宏，表示一秒有多少个时钟计时单元" }, t("CLOCKS_PER_SEC")),

	--------------------------- 创建可变参数的函数 -----------------------------------
	s({ trig = "va_list", dscr = "创建可变参数列表默认名为valist" }, t("va_list valist;")),
	s(
		{ trig = "va_start", dscr = "初始化可变参数列表,valist为默认列表,num为参数个数" },
		t("va_start(valist, num);")
	),
	s(
		{ trig = "va_arg", dscr = "使用列表中的下一个参数,默认参数类型为int" },
		sn(1, {
			t("va_arg(valist,"),
			i(1, "int"),
			t(")"),
		})
	),
	s({ trig = "va_end", dscr = "清理结束列表" }, t("va_end(valist);")),
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
				c(2, { i(1, "len"), sn(1, { t("sizeof("), i(1, "arr"), t(")") }) }),
				rep(1),
				i(3),
			}
		)
	),
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
		{ trig = "/ //", snippetType = "autosnippet" },
		sn(1, {
			t("/* "),
			i(1),
			t(" */"),
		})
	),
	-- debug
	s("debug", t('print("debug\\n");')),
}
