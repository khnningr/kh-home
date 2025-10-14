-- ================================================================================================
-- TITLE : lualine.nvim
-- LINKS :
--   > github: https://github.com/nvim-lualine/lualine.nvim
-- ABOUT : A blazing fast and easy to configure NeoVim statusline
-- ================================================================================================

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "melange",
        icons_enabled = true,
        section_separators = { left="", right = "" },
        component_separators = "|",
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {
          {
            'datetime',
            style = '%I:%M %p'  -- Formato 12 horas con AM/PM
          }
        }
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
