return function(lspconfig, capabilities, on_attach)
	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
		settings = {
			typescript = {
				indentStyle = "space",
				indetSize = 2,
			},
		},
	})
end
