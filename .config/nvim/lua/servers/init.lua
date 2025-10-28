local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("utils.lsp").on_attach
local lspconfig = require("lspconfig")
-- sudo pacman -S go

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
				},
			},
		},
	},
})

local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")

local flake8 = require("efmls-configs.linters.flake8")
local black = require("efmls-configs.formatters.black")

local eslint_d = require("efmls-configs.linters.eslint_d")
local prettier = require("efmls-configs.formatters.prettier")

lspconfig.efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"lua",
		"python",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"vue",
		"svelte",
		"solidity",
		"markdown",
		"html",
		"css",
		"docker",
		"json",
		"jsonc",
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
			lua = { luacheck, stylua },
			python = { flake8, black },
			typescript = { eslint_d, prettier },
			typescriptreact = { eslint_d, prettier },
			javascript = { eslint_d, prettier },
			javascriptreact = { eslint_d, prettier },
			vue = { eslint_d, prettier },
			svelte = { eslint_d, prettier },
			vue = { eslint_d, prettier },
			vue = { eslint_d, prettier },
		},
	},
})
-- 41.50min
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
