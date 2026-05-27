-- Onedark
  -- the colorscheme shnuld be available when starting Neovim
-- return  {
--     "navarasu/onedark.nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--     opts = {
--       style = 'darker'
--     },
--     config = function(_, opts)
--       -- load the colorscheme here
--       require('onedark').setup(opts)
--       require("onedark").load()
--     end,
-- }

-- Tokyodark
-- return {
--     "tiagovla/tokyodark.nvim",
--     opts = {
--         -- custom options here
--     },
--     config = function(_, opts)
--         require("tokyodark").setup(opts) -- calling setup is optional
--         vim.cmd [[colorscheme tokyodark]]
--     end,
-- }

-- Catppuccin
-- return {
--   "catppuccin/nvim",
--   priority = 1000,
--   opts = {
--     flavour = "latte"
--     -- custom options here
--   },
--   config = function(_, opts)
--   require("catppuccin").setup(opts) -- calling setup is optional
--   vim.cmd [[colorscheme catppuccin]]
--   end,
-- }

-- Nord
-- return {
--     'AlexvZyl/nordic.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('nordic').load()
--     end
-- }
return {
  -- 1. Load Onedark
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "darker" },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load() -- Start with Onedark as default
    end,
  },

  -- 2. Load Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "latte" },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },
  -- 3. Create the Toggle Command
  {
    "init_theme_toggle",
    dir = vim.fn.stdpath("config"),
    config = function()
      local is_onedark = true

      vim.api.nvim_create_user_command("ToggleTheme", function()
        if is_onedark then
          -- Catppuccin Latte is a light theme, so Neovim sets background=light
          vim.cmd([[colorscheme catppuccin]])
          print("Switched to Catppuccin!")
          is_onedark = false
        else
          -- FORCE Neovim back to dark mode so Onedark renders correctly
          vim.o.background = "dark"
          
          -- Reload Onedark safely
          local onedark_opts = require("lazy.core.config").plugins["onedark.nvim"].opts
          require("onedark").setup(onedark_opts)
          require("onedark").load()
          
          print("Switched to Onedark!")
          is_onedark = true
        end
      end, {})
    end,
  },
}
