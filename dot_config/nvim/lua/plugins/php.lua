return {
  -- Configure Conform for PHP formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },
        blade = { "blade-formatter" },
      },
    },
  },

  -- Configure Treesitter for Blade support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add blade parsers to ensure_installed
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "php_only",
      })
    end,
  },

  -- Configure blade filetype and parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {},
    config = function(_, opts)
      -- Only set up after treesitter is loaded
      pcall(function()
        -- Register blade filetype
        vim.filetype.add({
          pattern = {
            [".*%.blade%.php"] = "blade",
          },
        })

        -- Get parser config safely
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        if parser_config then
          parser_config.blade = {
            install_info = {
              url = "https://github.com/EmranMR/tree-sitter-blade",
              files = { "src/parser.c" },
              branch = "main",
            },
            filetype = "blade",
          }
        end
      end)
    end,
  },

  -- Configure Neotest for Pest testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "V13Axel/neotest-pest",
    },
    opts = {
      adapters = {
        ["neotest-pest"] = {},
      },
    },
  },
}
