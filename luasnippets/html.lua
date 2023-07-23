return {
	s("!", {
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

	s("$", {
		t('$("'),
		i(1),
		t('")'),
	}),

	s("lin", { t('<link rel="stylesheet" href="'), i(1), t('"/>') }),
}
