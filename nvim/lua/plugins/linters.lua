return {
	"mfussenegger/nvim-lint",
	opts = {
		linters = {
			["markdownlint-cli2"] = {
				prepend_args = {
					"--config",
					'{"MD013":{"line_length":120,"tables":false}}',
				},
			},
		},
	},
}
