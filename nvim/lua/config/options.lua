-- Options are automatically loaded before lazy.nvim startup
-- leader is space
vim.g.maplocalleader = " " -- local leader changed to space

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local opt = vim.opt

opt.background = "dark" -- set background to dark
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.breakindent = true -- enable break indent
opt.clipboard = "" -- do not use system clipboard (default in lazyvim)
opt.foldexpr = "v:lua.require 'lazyvim.util'.ui.foldexpr()" -- lazyvim fold expression
opt.foldtext = ""
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor" --disable curson blinking in terminal mode
opt.iskeyword:append("-") -- add dash to the list of word characters
opt.scrolloff = 8 -- minimum number of screen lines to keep above and below the cursor
opt.softtabstop = 4 -- one tab = 4 spaces
opt.shiftwidth = 4 -- Size of an indent (one tab = 4 spaces)
opt.showcmd = false
opt.smoothscroll = true -- Smooth scrolling
opt.swapfile = false -- Disable swap file
opt.tabstop = 4 -- Number of spaces tabs count for
opt.ttyfast = true -- faster scrolling
opt.vb = true -- turn off terminal beep
