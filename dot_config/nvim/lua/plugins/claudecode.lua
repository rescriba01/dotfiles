-- The claudecode extra needs the `claude` CLI; skip it on machines without one
return {
  { "coder/claudecode.nvim", enabled = vim.fn.executable("claude") == 1 },
}
