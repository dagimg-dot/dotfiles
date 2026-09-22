return {
	{
		"datsfilipe/vesper.nvim",
		priority = 1000,
		config = function()
			require("vesper").setup({})

			vim.cmd.colorscheme("vesper")

			-- Vesper palette accents
			local bg = "#101010"
			local fg = "#ffffff"
			local orange = "#ffc799"
			local aqua = "#99ffe4"
			local red = "#ff8080"
			local gray = "#a0a0a0"
			local dim = "#505050"
			local selection = "#2a2a2a"

			vim.api.nvim_set_hl(0, "Visual", {
				bg = selection,
				fg = fg,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Statusline", {
				bg = orange,
				fg = bg,
			})
			vim.api.nvim_set_hl(0, "LineNr", { fg = dim })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = orange, bold = true })

			vim.api.nvim_set_hl(0, "Statement", {
				fg = orange,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Keyword", { link = "Statement" })
			vim.api.nvim_set_hl(0, "Repeat", { link = "Statement" })
			vim.api.nvim_set_hl(0, "Conditional", { link = "Statement" })

			vim.api.nvim_set_hl(0, "Function", {
				fg = aqua,
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Macro", {
				fg = aqua,
				italic = true,
			})
			vim.api.nvim_set_hl(0, "@function.macro", { link = "Macro" })

			vim.api.nvim_set_hl(0, "Type", {
				fg = aqua,
				bold = true,
				italic = true,
			})
			vim.api.nvim_set_hl(0, "Structure", { link = "Type" })

			vim.api.nvim_set_hl(0, "String", {
				fg = aqua,
				italic = true,
			})

			vim.api.nvim_set_hl(0, "Error", { fg = red })
			vim.api.nvim_set_hl(0, "Operator", { fg = gray })
			vim.api.nvim_set_hl(0, "Delimiter", { fg = gray })
			vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Delimiter" })
			vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })

			vim.api.nvim_set_hl(0, "Comment", {
				fg = dim,
				italic = true,
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end,
	},
}
