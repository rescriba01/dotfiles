-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Intelephense instead of Phpactor
vim.g.lazyvim_php_lsp = "intelephense"

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- Treesitter-based folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldlevelstart = 99 -- Same, but for new buffers

-- Machine-type overrides. chezmoi deploys only this machine's file:
-- lua/config/machine_personal.lua or lua/config/machine_work.lua
for _, name in ipairs({ "config.machine_personal", "config.machine_work" }) do
  local ok, err = pcall(require, name)
  if not ok and not tostring(err):find("module '" .. name .. "' not found", 1, true) then
    vim.notify("Error loading " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
  end
end
