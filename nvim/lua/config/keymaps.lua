-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Thanks to "The Primeagen" for some of the keymap ideas

-- Jump to start and end of line using the home row keys
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")

-- jk to escape from insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- select all
vim.keymap.set("n", "<C-a", "gg<S-v>G", { desc = "Select all" })

-- Allow half page jumpings to keep the cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- moving tabs conveniently
vim.keymap.set("n", "<leader>1", "1gt", { desc = "Move to tab 1" })
vim.keymap.set("n", "<leader>2", "2gt", { desc = "Move to tab 2" })
vim.keymap.set("n", "<leader>3", "3gt", { desc = "Move to tab 3" })
vim.keymap.set("n", "<leader>4", "4gt", { desc = "Move to tab 4" })
vim.keymap.set("n", "<leader>5", "5gt", { desc = "Move to tab 5" })

-- Allow to copy paste and dont have the buffer reinitialized after pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Unmaps Q in normal mode (default is to record a macro)
vim.keymap.set("n", "Q", "<nop>")

-- Replace the word cursor is on globally
vim.keymap.set(
	"n",
	"<leader>snr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)

-- Auto-yank visual selection to the system clipboard on mouse release
-- NOTE: This requires Neovim to receive mouse events (so `mouse` must include visual mode)
-- NOTE: LazyVim already enables `opt.mouse = "a"` (mouse mode), so we don't set it here
vim.keymap.set("v", "<LeftRelease>", [["+ygv]], { silent = true, desc = "[P]Mouse select -> yank to system clipboard" })
vim.keymap.set(
	"v",
	"<2-LeftRelease>",
	[["+ygv]],
	{ silent = true, desc = "[P]Mouse select (double) -> yank to system clipboard" }
)

-- delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- interactions with the system copy buffers
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- map semi-colon to colon in normal mode
vim.keymap.set("n", ";", ":", { noremap = true, silent = true })

-- Search/grep notes from the notes folder usng fzf-lua
vim.keymap.set("n", "<leader>ns", ":FzfLua files cwd=~/Documents/notes/<cr>")
vim.keymap.set("n", "<leader>ng", ":FzfLua live_grep cwd=~/Documents/notes/<cr>")

-- Disable arrow keys in normal mode - remove later after muscle memory
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
