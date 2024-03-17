return {
  {
    "Saecki/crates.nvim",
    -- tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
  },
}
