-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Treesitter configurations and abstraction layer for NeoVim.
-- LINKS :
--   > github: https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      -- language parsers that MUST be installed
      ensure_installed = {
        "lua",
        "python",
        "bash",
        -- "typescript"
        "javascript",
        "html",
        "css",
        "json",
        "yaml",
        "go",
        "markdown",
        "dockerfile",
        "markdown_inline",
        -- "c",
        "cpp",
        -- "vue",
        -- "svelte",
        "desktop",
        "java",
        "rust",
        "scss",
        "ssh_config",
        "tmux",
        "toml",
        "vim",
        "yuck",
        "hyprlang",
        "qmldir",
        "qmljs"

      },
      auto_install = true, -- auto-install any other parsers on opening new
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<TAB>",
        node_decremental = "<S-TAB>",k
      },
    },
  })
end,
}
