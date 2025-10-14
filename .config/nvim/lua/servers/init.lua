local on_attach = require('utils.lsp').on_attach
local lspconfig = require('lspconfig')
-- sudo pacman -S go
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua"
        }
      }
    }
  }
})

local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")

lspconfig.efm.setup({
  on_attach = on_attach,
  filetypes = {
    "lua",

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
      lua = { luacheck, stylua }
    }
  }
})
