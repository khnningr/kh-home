-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field (fs_stat)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Puedes usar este comando para ir al archivo: normal: gf
require("config.options")
require("config.globals")
require("config.keymaps")
require("config.autocmds")

local plugins_dir = "plugins"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = plugins_dir },
  },
  rtp = {
    disabled_plugins = {
      "netrw",
      "netrwPlugin"
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "melange" } },
  install = { colorscheme = { "github_dark_default" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
