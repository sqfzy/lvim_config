return {
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

	s("!!", {
		t({ "<!DOCTYPE html>" }),
		t({ "", '<html lang="zn">' }),
		t({ "", "", "<head>" }), --""转行
		t({ "", '  <meta charset = "UTF-8">' }),
		t({
			"",
			'  <meta name="viewport" content="width=device-width, initial-csale=1, maximum-scale=1, user-scalable=no">',
		}),
		t({ "", "</head>" }),
		t({ "", "", "<body>" }),
		t({ "", "", "  " }),
		i(1),
		t({ "", "", "</body>" }),
		t({ "", "", "</html>" }),
	}),
	s("!", {
		t({ "<?php" }),
		t({ "", "  " }),
		i(1),
		t({ "", "?>" }),
	}),
	s({ trig = "filterFormData", describe = "检查表单提交的数据" }, {
		t({ "function filterFormData($data){" }),
		t({ "", "  $data = trim($data);" }),
		t({ "", "  $data = stripslashes($data);" }),
		t({ "", "  $data = htmlspecialchars($data);" }),
		t({ "", "  return $data;" }),
		t({ "", "}" }),
	}),
}
