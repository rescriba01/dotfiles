return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = opts.sources or {}

    -- Add Tailwind Tools as a source
    table.insert(opts.sources, {
      name = "tailwind-tools",
      option = {},
    })

    return opts
  end,
}
