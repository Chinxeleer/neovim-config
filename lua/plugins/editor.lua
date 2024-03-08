return {
  --   {
  --     "nvim-tree/nvim-tree.lua",
  --     cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  --     config = function()
  --       require("nvim-tree").setup({
  --         disable_netrw = true,
  --         hijack_netrw = true,
  --         open_on_tab = false,
  --         hijack_cursor = true,
  --         hijack_unnamed_buffer_when_opening = false,
  --         update_cwd = true,
  --         update_focused_file = {
  --           enable = true,
  --           update_cwd = false,
  --         },
  --         sync_root_with_cwd = true,
  --         view = {
  --           width = 20,
  --           hide_root_folder = false,
  --         },
  --         git = {
  --           enable = false,
  --           ignore = true,
  --         },
  --         actions = {
  --           open_file = {
  --             resize_window = true,
  --           },
  --         },
  --         renderer = {
  --           indent_markers = {
  --             enable = false,
  --           },
  --         },
  --       })
  --     end,
  --   },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   config = function()
  --     require("telescope").setup({})
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "toml",
      },
    },
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "pnpm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },
}
