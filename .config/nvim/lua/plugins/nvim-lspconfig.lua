-- Servidores de Lenguaje en Mason:
-- NOTA: Para instalar un servidor, se usa la 'i'.
--    lua-language-server, luacheck, stylua
--    efm,

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("utils.diagnostics").setup()
		require("servers")
	end,
}
