return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				harper_ls = {
					filetypes = { "markdown", "org", "tex", "text", "typst" },

					settings = {
						["harper-ls"] = {
							userDictPath = "",
							workspaceDictPath = "",
							fileDictPath = "",

							linters = {
								SpellCheck = true,
								SpelledNumbers = false,
								AnA = true,
								SentenceCapitalization = true,
								UnclosedQuotes = true,
								WrongApostrophe = false,
								LongSentences = true,
								RepeatedWords = true,
								Spaces = true,
								CorrectNumberSuffix = true,
							},

							codeActions = {
								ForceStable = false,
							},

							markdown = {
								IgnoreLinkTitle = false,
							},

							diagnosticSeverity = "hint",
							isolateEnglish = false,
							dialect = "American",
							maxFileLength = 120000,
							ignoredLintsPath = "",
							excludePatterns = {},
						},
					},
				},
			},
		},
	},
}
