-- old version - that causes error as blink is updated to new API call and lazyvim is still not updated, remove new version and use old when lazyvim is updated
-- return {
-- 	-- change blink config
-- 	"saghen/blink.cmp",
-- 	opts = {
-- 		keymap = { preset = "super-tab" },
-- 	},
-- }
--
return {
	"saghen/blink.cmp",
	opts = {
		keymap = {
			preset = "super-tab",
			["<Tab>"] = {
				require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
				require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
				"fallback",
			},
		},
	},
}
