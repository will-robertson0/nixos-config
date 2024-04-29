require("telescope").setup {
	extensions = {
		file_browser = {
			theme = "carbonfox",
		},
	},
}
 
-- require("telescope").load_extension "file_browser"
-- this one had to go to init.lua ^ 

vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- vim.keymap.set("n", "<space>fb", function()
-- 	require("telescope").extensions.file_browser.file_browser()
-- end)
