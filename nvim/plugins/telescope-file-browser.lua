require("telescope").setup {
	extensions = {
		file_browser = {
			theme = "carbonfox",
		},
	},
}

vim.keymap.set("n", "<space>fb", ":lescope file_browser<CR>")

vim.keymap.set("n", "<leader>fb", function()
	require("telescope").extensions.file_browser.file_browser()
end)


