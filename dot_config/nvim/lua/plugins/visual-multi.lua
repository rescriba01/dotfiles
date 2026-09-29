return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy", -- Load it when needed, not on startup
    init = function()
      -- Optional: customize vim-visual-multi settings here
      -- These run before the plugin loads
      vim.g.VM_mouse_mappings = 1 -- Enable mouse support if you want
      vim.g.VM_theme = "iceblue" -- Change theme (optional)
    end,
  },
}
