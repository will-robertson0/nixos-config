{ config, pkgs, inputs, ... }:

{
  imports = [
	inputs.nix-colors.homeManagerModules.default
  	./features/mako.nix
  ];

  home.username = "wjr";
  home.homeDirectory = "/home/wjr";
  home.stateVersion = "23.11"; # don't change

  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  
  # github
  programs.git = {
  	enable = true;
	userName = "will-robertson0";
	userEmail = "wj.robertson24@gmail.com";
	aliases = {
		pu = "push";
		co = "checkout";
		cm = "commit";
	};
  };


  
  # kitty!
  programs.kitty = {
  	enable = true;
    theme = "Corvine"; # select from kitty +kitten themes
    shellIntegration.enableFishIntegration = true;
	settings = {
		background_opacity = "0.84"; # 0.84
		confirm_os_window_close = 0;
		scrollback_lines = "10000";
		window_padding_width = 8;
        shell = "fish";
        # background_image = "/home/wjr/Downloads/IMG_20231228_013528_973.png";
        # background_image_layout = "scaled";
        # background_tint = "0.0";
	};
  };



  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     set fish_greeting # Disable greeting
  #   '';
  # };



  # neovim
  programs.neovim = 
  let
  	toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
  	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;

	extraLuaConfig = ''
		-- assigning <leader> key to space
		vim.g.mapleader = ' '
		vim.g.maplocalleader = ' '

		vim.o.clipboard = 'unnamedplus'

		vim.o.number = true
		-- vim.o.relativenumber = true

		vim.o.signcolumn = 'yes'

		vim.o.tabstop = 4
		vim.o.shiftwidth = 4

		vim.o.updatetime = 300

		vim.o.termguicolors = true

		vim.o.mouse = 'a'
	'';
	
	plugins = with pkgs.vimPlugins; [

		{
		   plugin = comment-nvim;
		   type = "lua";
		   config = "require(\"Comment\").setup()";
		}

		{
			plugin = nvim-colorizer-lua;
			type = "lua";
			config = "require(\"colorizer\").setup()";
		}

		{
			plugin = nightfox-nvim;
			type = "lua";
			config = "
				require(\'nightfox\').setup({
					options = { transparent = true, },
				})
				vim.cmd(\"colorscheme carbonfox\")
                local palettes = {
                  carbonfox = {
                    green = { base = \"##87af5f\", bright = \"##87af5f\", dim = \"##87af5f\" },
                } },";
		}

		{
			plugin = lualine-nvim;
			type = "lua";
			config = "
				require(\"lualine\").setup({
					icons_enabled = true,
					theme = 'carbonfox',
					section_separators = '',
					component_separators = '',
				})";
		}

        # { 
        #     plugin = telescope-file-browser-nvim;
        #     type = "lua";
        #     config = "
        #         require(\"telescope\").setup { extensions = { file_browser = {
        #             theme = \"carbonfox\",
        #         }, }, }
        #         -- vim.keymap.set(\"n\", \"<space>fb\", \":Telescope file_browser<CR>\")
        #         vim.keymap.set(\"n\", \"<leader>fb\", function()
        #             require(\"telescope\").extensions.file_browser.file_browser()
        #         end)
        #         ";
        # }

		{
			plugin = nvim-lspconfig;
			config = toLuaFile ./nvim/plugins/lsp.lua;
		}

		{
			plugin = nvim-cmp;
			config = toLuaFile ./nvim/plugins/cmp.lua;
		}

		{
			plugin = telescope-nvim;
			config = toLuaFile ./nvim/plugins/telescope.lua;
		}

		{
			plugin = (nvim-treesitter.withPlugins (p: [
				p.tree-sitter-nix
				p.tree-sitter-vim
				p.tree-sitter-bash
				p.tree-sitter-lua
				p.tree-sitter-python
				p.tree-sitter-json
				# p.tree-sitter-rust
				# p.tree-sitter-c
			]));
			config = toLuaFile ./nvim/plugins/treesitter.lua;
		}


            

		vim-nix
		
		neodev-nvim
		
		telescope-fzf-native-nvim
		
		cmp_luasnip

		cmp-nvim-lsp
		
		luasnip

		friendly-snippets
		
		nvim-web-devicons
	];
  };




  colorScheme = {
  	slug = "corvine";
	name = "Corvine";
	author = "arzg (https://github.com/arzg/vim-corvine)";
	palette = {
		base00 = "#262626"; # bg0 -- used to be 3a3a3a
		base01 = "#d78787";
		base02 = "#87af5f";
		base03 = "#d7d7af";
		base04 = "#87afd7";
		base05 = "#afafd7";
		base06 = "#87d7d7";
		base07 = "#c6c6c6";
		base08 = "#626262";
		base09 = "#ffafaf";
		base0A = "#afd787";
		base0B = "#d7d787";
		base0C = "#87d7ff";
		base0D = "#d7afd7";
		base0E = "#5fd7d7";
		base0F = "#eeeeee";
	};
  };
}
