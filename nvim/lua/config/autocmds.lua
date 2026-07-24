-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- store original vimwiki_list config, we will need it later
-- !!!make sure vimwiki plugin is loaded before running this!!!

-- Open Help to right split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd.wincmd("L")
	end,
})

-- Disable auto comment continuation on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
	pattern = { "lua", "python", "javascript", "typescript", "sh" },
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o", "q" })
	end,
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- add template for source notes [TODO: update the abstract and bibliography sections with admonitions]
-- vim.api.nvim_create_autocmd("BufNewFile", {
--     pattern = { "*/notes/sources/*.md"},
--     callback = function()
--     local today = os.date("%Y-%m-%d") -- 2025-08-08
-- local template = string.format([[
-- ---
-- Title: "{{title}}"
-- Authors: "{{authors}}"
-- Year: "{{date | format("YYYY")}}"
-- Type: "{{itemType}}"
-- Conference: "{{proceedingsTitle}}"
-- Series: "{{series}}"
-- citekey: "{{citationKey}}"
-- tags:
-- Purpose_of_reading:
-- Read_date: %s
-- ---
-- [Zotero link]({{desktopURI}})
--
-- [Online link]({{url}})
--
-- ## Key Takeaways
--
-- ### Abstract
--
-- ### Bibliography
--
-- -------
-- ## Summary
--
-- ## Research Questions
--
-- ## Takeaways/Examples
--
-- ## Questions & confusions
--
-- ## Connection to existing works
--
-- ## Applications/Implications
--
-- ## Limitations
-- ]], today)
--
--     vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(template, "\n"))
--   end,
-- })

-- add diary template for every new file
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*/notes/diary/*.md" },
	callback = function()
		local date = os.date("%A, %B %d, %Y") -- Saturday, June 28, 2025
		local template = string.format(
			[[
# %s

## Todo

- [ ]

## Notes
]],
			date
		)
		vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(template, "\n"))
	end,
})
