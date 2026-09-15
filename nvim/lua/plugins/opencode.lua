return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = { enabled = True }, -- Enhances `ask()`
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
				terminal = {}, -- Enables the `snacks` provider
			},
		},
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any; goto definition on the type for details
		}

		-- Recommended/example keymaps
		vim.keymap.set({ "n", "x" }, "<C-a>", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode…" })
		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			require("opencode").select()
		end, { desc = "Select OpenCode…" })
		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Append range to OpenCode", expr = true })
		vim.keymap.set({ "n" }, "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Append line to OpenCode", expr = true })
		vim.keymap.set({ "n" }, "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll OpenCode up" })
		vim.keymap.set({ "n" }, "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll OpenCode down" })
	end,
}
