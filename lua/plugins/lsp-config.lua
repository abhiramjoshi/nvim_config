return {
  {
    "mason-org/mason.nvim",
    --version ="^1.0.0"
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    --version ="^1.0.0",
    --dependencies = { "mason.nvim","nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "pylsp", "ruff", "ts_ls", "gopls", "yamlls" },
        automatic_installation = false,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    --dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local pyright_capabilities = capabilities
      pyright_capabilities.textDocument.completion.completionItem.snippetSupport = false
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
      --lspconfig.pylsp.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = pyright_capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic'
            }
          }
        }
      })
      lspconfig.ruff.setup({
        on_attach = on_attach,
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
        on_attach = on_attach,
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        on_attach = on_attach,
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
      lspconfig.djlsp.setup({
        on_attach = on_attach,
        cmd = { "djlsp" }
      })
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      lspconfig.terraformls.setup({
        on_attach = on_attach,
      })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*.tf", "*.tfvars" },
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end,
  },
}
