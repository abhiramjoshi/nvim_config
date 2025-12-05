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
return {
  "catppuccin/nvim",
  priority = 1000,
  opts = {
    flavour = "latte"
    -- custom options here
  },
  config = function(_, opts)
  require("catppuccin").setup(opts) -- calling setup is optional
  vim.cmd [[colorscheme catppuccin]]
  end,
}

-- Nord
-- return {
--     'AlexvZyl/nordic.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('nordic').load()
--     end
-- }
