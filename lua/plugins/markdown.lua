return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    config = function ()
      require("render-markdown").setup({
        enabled = true,
        render_modes = {"n", "c", "t"}
      })
    end
  }
}
