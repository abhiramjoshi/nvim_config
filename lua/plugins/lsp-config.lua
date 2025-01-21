return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls", "gopls", "gh_actions_ls", "yamlls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.ruff.setup({
        capabilities = capabilities,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          },
        },
      })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.gh_actions_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities
        --init_options = {
        --  settings = {
        --    yaml = {
        --      schemas = {
        --        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        --        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
        --        ["/path/from/root/of/project"] = "/.github/workflows/*",
        --      },
        --    },
        --  }
        --}
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
