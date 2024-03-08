return {
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          close_command = "bp|sp|bn|bd! %d",
          right_mouse_command = "bp|sp|bn|bd! %d",
          left_mouse_command = "buffer %d",
          buffer_close_icon = "",
          modified_icon = "",
          close_icon = "",
          show_close_icon = false,
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 10,
          show_tab_indicators = true,
          indicator = {
            style = "underline",
          },
          enforce_regular_tabs = false,
          view = "multiwindow",
          show_buffer_close_icons = true,
          separator_style = "thin",
          -- separator_style = "slant",
          always_show_bufferline = true,
          diagnostics = false,
          themable = true,
        },
      })

      vim.o.showtabline = 0

      -- Buffers belong to tabs
      local cache = {}
      local last_tab = 0

      local utils = {}

      utils.is_valid = function(buf_num)
        if not buf_num or buf_num < 1 then
          return false
        end
        local exists = vim.api.nvim_buf_is_valid(buf_num)
        return vim.bo[buf_num].buflisted and exists
      end

      utils.get_valid_buffers = function()
        local buf_nums = vim.api.nvim_list_bufs()
        local ids = {}
        for _, buf in ipairs(buf_nums) do
          if utils.is_valid(buf) then
            ids[#ids + 1] = buf
          end
        end
        return ids
      end

      local autocmd = vim.api.nvim_create_autocmd

      autocmd("TabEnter", {
        callback = function()
          local tab = vim.api.nvim_get_current_tabpage()
          local buf_nums = cache[tab]
          if buf_nums then
            for _, k in pairs(buf_nums) do
              vim.api.nvim_buf_set_option(k, "buflisted", true)
            end
          end
        end,
      })
      autocmd("TabLeave", {
        callback = function()
          local tab = vim.api.nvim_get_current_tabpage()
          local buf_nums = utils.get_valid_buffers()
          cache[tab] = buf_nums
          for _, k in pairs(buf_nums) do
            vim.api.nvim_buf_set_option(k, "buflisted", false)
          end
          last_tab = tab
        end,
      })
      autocmd("TabClosed", {
        callback = function()
          cache[last_tab] = nil
        end,
      })
      autocmd("TabNewEntered", {
        callback = function()
          vim.api.nvim_buf_set_option(0, "buflisted", true)
        end,
      })
    end,
  },
  {
    "feline-nvim/feline.nvim",
    config = function()
      require("feline").setup({
        components = require("catppuccin.groups.integrations.feline").get(),
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},

    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },

  -- {
  -- 	"lukas-reineke/indent-blankline.nvim",
  -- 	config = function()
  -- 		require("indent_blankline").setup {
  -- 			char = "▏",
  -- 			char_blankline = " ",
  -- 			filetype_exclude = { "help", "terminal", "lspinfo", "TelescopePrompt", "TelescopeResults" },
  -- 			buftype_exclude = { "terminal" },
  -- 			show_first_indent_level = false,
  -- 		}
  -- 	end,
  -- },
  --   {
  --     "akinsho/toggleterm.nvim",
  --     cmd = { "ToggleTerm", "TermExec" },
  --     config = function()
  --       require("toggleterm").setup({
  --         size = function(term)
  --           if term.direction == "horizontal" then
  --             return 12
  --           elseif term.direction == "vertical" then
  --             return vim.o.columns * 0.4
  --           end
  --         end,
  --         hide_numbers = true,
  --         shade_filetypes = {},
  --         shade_terminals = true,
  --         shading_factor = "1",
  --         start_in_insert = true,
  --         insert_mappings = true,
  --         terminal_mappings = true,
  --         persist_size = true,
  --       })
  --
  --       vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "BufWinEnter", "WinEnter" }, {
  --         pattern = "term://*",
  --         callback = function()
  --           vim.api.nvim_command("startinsert")
  --         end,
  --       })
  --     end,
  --   },
  --   {
  --     "lewis6991/gitsigns.nvim",
  --     config = function()
  --       require("gitsigns").setup({
  --         signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  --         numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  --         linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  --         word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  --         watch_gitdir = {
  --           interval = 1000,
  --           follow_files = true,
  --         },
  --         attach_to_untracked = true,
  --         current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  --         current_line_blame_opts = {
  --           virt_text = true,
  --           virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
  --           delay = 1000,
  --         },
  --         current_line_blame_formatter_opts = {
  --           relative_time = false,
  --         },
  --         sign_priority = 0,
  --         update_debounce = 100,
  --         status_formatter = nil, -- Use default
  --         max_file_length = 40000,
  --         preview_config = {
  --           -- Options passed to nvim_open_win
  --           border = "single",
  --           style = "minimal",
  --           relative = "cursor",
  --           row = 0,
  --           col = 1,
  --         },
  --         yadm = {
  --           enable = false,
  --         },
  --       })
  --     end,
  --     lazy = true,
  --     init = function()
  --       if vim.fn.isdirectory(".git") ~= 0 then
  --         require("lazy").load({ plugins = "gitsigns.nvim" })
  --       end
  --     end,
  --   },
  --   {
  --     "folke/noice.nvim",
  --     opts = function(_, opts)
  --       table.insert(opts.routes, {
  --         filter = {
  --           event = "notify",
  --           find = "No information available",
  --         },
  --         opts = {
  --           skip = true,
  --         },
  --       })
  --     end,
  --   },
}
