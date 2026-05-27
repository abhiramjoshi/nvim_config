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
    config = function()
      --------------------------------------------------------------------
      -- Shared LSP settings
      --------------------------------------------------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      --------------------------------------------------------------------
      -- Server configurations (new API)
      --------------------------------------------------------------------

      -- Go
      vim.lsp.config("gopls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Pyright
      local pyright_capabilities = vim.deepcopy(capabilities)
      pyright_capabilities.textDocument.completion.completionItem.snippetSupport = false

      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = pyright_capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- Ruff
      vim.lsp.config("ruff", {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          settings = {
            args = {},
          },
        },
      })

      -- TypeScript
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- GitHub Actions
      vim.lsp.config("gh_actions_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- YAML
      vim.lsp.config("yamlls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- DJLSP
      vim.lsp.config("djlsp", {
        on_attach = on_attach,
        cmd = { "djlsp" },
      })

      -- HTML
      vim.lsp.config("html", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Terraform
      vim.lsp.config("terraformls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      --------------------------------------------------------------------
      -- Enable all servers
      --------------------------------------------------------------------
      vim.lsp.enable("gopls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("gh_actions_ls")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("djlsp")
      vim.lsp.enable("html")
      vim.lsp.enable("terraformls")

      --------------------------------------------------------------------
      -- Global LSP keymaps
      --------------------------------------------------------------------
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definiton" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })


      --------------------------------------------------------------------
      -- Terraform autoformat
      --------------------------------------------------------------------
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*.tf", "*.tfvars" },
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   --dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     local on_attach = function(client, bufnr)
  --       if client.server_capabilities.documentFormattingProvider then
  --         vim.api.nvim_create_autocmd("BufWritePre", {
  --           group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
  --           buffer = bufnr,
  --           callback = function()
  --             vim.lsp.buf.format({ bufnr = bufnr })
  --           end,
  --         })
  --       end
  --     end
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     local pyright_capabilities = capabilities
  --     pyright_capabilities.textDocument.completion.completionItem.snippetSupport = false
  --     lspconfig.gopls.setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --     lspconfig.lua_ls.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities
  --     })
  --     --lspconfig.pylsp.setup({ capabilities = capabilities })
  --     lspconfig.pyright.setup({
  --       on_attach = on_attach,
  --       capabilities = pyright_capabilities,
  --       settings = {
  --         python = {
  --           analysis = {
  --             typeCheckingMode = 'basic'
  --           }
  --         }
  --       }
  --     })
  --     lspconfig.ruff.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --       init_options = {
  --         settings = {
  --           -- Any extra CLI arguments for `ruff` go here.
  --           args = {},
  --         },
  --       },
  --     })
  --     lspconfig.ts_ls.setup({ capabilities = capabilities })
  --     lspconfig.gh_actions_ls.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --     })
  --     lspconfig.yamlls.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities
  --       --init_options = {
  --       --  settings = {
  --       --    yaml = {
  --       --      schemas = {
  --       --        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
  --       --        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
  --       --        ["/path/from/root/of/project"] = "/.github/workflows/*",
  --       --      },
  --       --    },
  --       --  }
  --       --}
  --     })
  --     lspconfig.djlsp.setup({
  --       on_attach = on_attach,
  --       cmd = { "djlsp" }
  --     })
  --     lspconfig.html.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities
  --     })
  --     vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  --     vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
  --     lspconfig.terraformls.setup({
  --       on_attach = on_attach,
  --     })
  --     vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  --       pattern = { "*.tf", "*.tfvars" },
  --       callback = function()
  --         vim.lsp.buf.format()
  --       end,
  --     })
  --   end,
  -- },
}
