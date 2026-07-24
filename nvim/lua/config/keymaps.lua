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

-- source and update neovim config
vim.keymap.set("n", "<leader>so", function()
	vim.cmd("update")
	vim.cmd("source $MYVIMRC")
end, { silent = true, desc = "Source and update neovim config" })

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

-- Copy file path / selection reference for pasting
-- taken from https://github.com/smnatale/dotfiles/blob/main/nvim/.config/nvim/lua/config/keymaps.lua
local function copy_ref(opts)
	-- "%" is the current buffer's file name; ":." makes it relative to the cwd
	local path = vim.fn.expand("%:.")
	-- ref is what ends up in the clipboard; start with just the path
	local ref = path

	if opts.visual then
		-- '< and '> are only set after leaving visual mode, so read the live selection:
		-- "v" is the line where visual mode was started (the anchor)
		local start_line = vim.fn.line("v")
		-- "." is the line the cursor is on now (the moving end of the selection)
		local end_line = vim.fn.line(".")
		-- if the selection was made upward, swap so start is always the smaller line
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		-- append the range, e.g. "lua/config/keymaps.lua:1:23"
		ref = path .. ":" .. start_line .. ":" .. end_line
	end

	-- write ref into the "+" register, which is the system clipboard
	vim.fn.setreg("+", ref)
	-- show a confirmation message with what was copied
	vim.notify("Copied: " .. ref)
end

-- normal mode: copy just the file path
vim.keymap.set("n", "<leader>cp", function()
	copy_ref({})
end, { desc = "Copy file path" })

-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
	copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

-- Disable arrow keys in normal mode - remove later after muscle memory
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
