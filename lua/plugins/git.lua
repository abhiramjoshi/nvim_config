return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("neogit").setup({
        kind = "split",
        signs = {
          -- { CLOSED, OPENED }
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = { diffview = true },
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '┃' },
          delete       = { text = '-' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil, -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })

      vim.keymap.set('n', '<leader>gg', ':terminal git status<CR>', {desc="Git status"})
      vim.keymap.set('n', '<leader>gc', ':terminal git commit<CR>', {desc="Git commit"})
      vim.keymap.set('n', '<leader>gp', ':terminal git push<CR>', {desc="Git push"})
      vim.keymap.set('n', '<leader>gL', ':terminal git pull<CR>', {desc="Git pull"})
      vim.keymap.set('n', '<leader>gl', ':terminal git log --oneline --graph --decorate --all<CR>', {desc="Git log"})
      vim.keymap.set('n', '<leader>ga', ':!git add %<CR>', {desc="Git add current file"})
      vim.keymap.set('n', '<leader>gA', ':!git add .<CR>', {desc="Git add all"})
      vim.keymap.set('n', '<leader>gu', ':!git add -u<CR>', {desc="Git add updates"})
      vim.keymap.set('n', '<leader>gs', ':terminal git status<CR>', {desc="Git status"})
      vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>', {desc="Diff current file"})
      vim.keymap.set('n', '<leader>gD', ':terminal git diff<CR>', {desc="Git diff all"})
    end
  }
}
