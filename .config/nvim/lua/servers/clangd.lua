-- ================================================================================================
-- TITLE : clangd (C/C++ Language Server) LSP Setup
-- LINKS :
--   > website: https://clangd.llvm.org/
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("clangs", {
		capabilities = capabilities,
		cmd = {
			"clangd",
			"--offset-encoding=utf16",
		},
		filetypes = { "c", "cpp" },
	})
end
