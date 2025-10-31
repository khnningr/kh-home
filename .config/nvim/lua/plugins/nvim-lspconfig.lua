-- ================================================================================================
-- TITLE : nvim-lspconfig
-- ABOUT : Quickstart configurations for the built-in Neovim LSP client.
-- LINKS :
--   > github                    : https://github.com/neovim/nvim-lspconfig
--   > mason.nvim (dep)          : https://github.com/mason-org/mason.nvim
--   > efmls-configs-nvim (dep  ): https://github.com/creativenull/efmls-configs-nvim
--   > cmp-nvim-lsp (dep)        : https://github.com/hrsh7th/cmp-nvim-lsp
--   > mason-tool-installer(dep) : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================
-- Servidores de Lenguaje en Mason:
-- NOTA: Para instalar un servidor, se usa la 'i'.
--    lua-language-server, luacheck, stylua
--    efm,

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} }, -- LSP/DAP/Linter installer & manager
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"creativenull/efmls-configs-nvim", -- Preconfigured EFM Language Server setups
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for LSP-based completion
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP
				"lua-language-server",
				"efm",
				"pyright",
				"typescript-language-server",
				"gopls",
				"bash-language-server",
				"docker-language-server",
				"clangd",
				"emmet-language-server",
				"json-lsp",
				"tailwindcss-language-server",
				"yaml-language-server",

				-- Linters
				"luacheck",
				"flake8",
				"eslint_d",
				"revive",
				"shellcheck",
				"hadolint",
				"cpplint",

				-- Formatters
				"stylua",
				"black",
				"prettier",
				"fixjson",
				"gofumpt",
				"shfmt",
				"clang-format",
			},
		})
		require("utils.diagnostics").setup()
		require("servers")
	end,
}
