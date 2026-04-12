return {
	-- Combining text and insert nodes to create basic LaTeX commands
	-- \texttt
	s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { i(1) })),

	-- Snippet for auto end tag for every begin
	s(
		{ trig = "env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			}
		)
	),
}
