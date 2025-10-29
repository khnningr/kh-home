return function(lspconfig, capabilities, on_attach)
	lspconfig.pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "python" },
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					autoImportCompletions = true,
				},
			},
		},
	})
end
