local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[|::::::::'   .':     o`:::::::::::|]],
	[[|:::::::' oo | |o  o    ::::::::::|]],
	[[|::::::: 8  .'.'    8 o  :::::::::|]],
	[[|::::::: 8  | |     8    :::::::::|]],
	[[|::::::: _._| |_,...8    :::::::::|]],
	[[|::::::'~--.   .--. `.   `::::::::|]],
	[[|:::::'     =8     ~  \ o ::::::::|]],
	[[|::::'   _   8.  _.    \ o::::::::|]],
	[[|:::'     . ,.ooo~~.    \ o`::::::|]],
	[[|:::   . -. 88`78o/:     \  `:::::|]],
	[[|::'     /. o o \ ::      \88`::::|]],
	[[|:;     o|| 8 8 |d.        `8 `:::|]],
	[[|:.       - ^ ^ -'           `-`::|]],
	[[|::.                          .:::|]],
	[[]],
	[[     "He will join us or die."]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.local/share/chezmoi/dot_config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.config.opts.noautocmd = false
alpha.setup(dashboard.config)
