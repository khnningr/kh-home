return function(lspconfig, capabilities, on_attach)
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier = require("efmls-configs.formatters.prettier")

	local fixjson = require("efmls-configs.formatters.fixjson")

	lspconfig.efm.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"css",
			"docker",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"solidity",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				css = { prettier },
				docker = { prettier },
				html = { prettier },
				javascript = { eslint_d, prettier },
				javascriptreact = { eslint_d, prettier },
				json = { fixjson, eslint_d },
				jsonc = { fixjson, eslint_d },
				lua = { luacheck, stylua },
				markdown = { prettier },
				python = { flake8, black },
				solidity = { prettier },
				svelte = { eslint_d, prettier },
				typescript = { eslint_d, prettier },
				typescriptreact = { eslint_d, prettier },
				vue = { eslint_d, prettier },
			},
		},
	})
end
