{ config, pkgs, inputs, lib, ... }:

{
  imports = [
	inputs.nix-colors.homeManagerModules.default
  	./features/mako.nix
    ./features/alacritty.nix
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
    # ".gradle/radle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  home.sessionVariables = {
    EDITOR = "nvim";
    DEFAULT_BROWSER = lib.getExe pkgs.chromium;
    BROWSER = lib.getExe pkgs.chromium;
  };

  xdg.desktopEntries = {
    ladybird = {
      name = "Ladybird";
      genericName = "Web Browser";
      exec = "Ladybird";
      terminal = false;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "chromium-browser.desktop";
    "x-scheme-handler/http" = "chromium-browser.desktop";
    "x-scheme-handler/https" = "chromium-browser.desktop";
    "x-scheme-handler/about" = "chromium-browser.desktop";
    "x-scheme-handler/unknown" = "chromium-browser.desktop";
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
		# window_padding_width = 8;
        shell = "fish";
        # background_image = "/home/wjr/Downloads/IMG_20231228_013528_973.png";
        # background_image_layout = "scaled";
        # background_tint = "0.0";
        font_family = "JuliaMono";
        # reminder: ctrl+shft+= to scale text
	};
  };



  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     shell = "fish";
  #     window = {
  #       blur = true;
  #       opacity = 0.84;
  #     };
  #   };
  # };



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
    toLua = str: "lua << EOF\n${str}\nEOF\n";
  in
  {
  	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      # wl-clipboard # moved back to configuration.nix
      rust-analyzer
      pyright
      llvmPackages_18.clang-unwrapped
      gopls
    ];

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
            plugin = undotree;
            type = "lua";
            config = builtins.readFile(./nvim/plugin/undotree.lua);
        }

		{
			plugin = lualine-nvim;
            type = "lua";
			config = builtins.readFile(./nvim/plugin/lualine.lua);
        } 

        { 
            plugin = telescope-file-browser-nvim;
            type = "lua";
            config = builtins.readFile(./nvim/plugin/telescope-file-browser.lua);
        }

		{
			plugin = nvim-lspconfig;
            type = "lua";
			config = builtins.readFile(./nvim/plugin/lsp.lua);
		}

		{
			plugin = nvim-cmp;
            type = "lua";
			config = builtins.readFile(./nvim/plugin/cmp.lua);
		}

		{
			plugin = telescope-nvim;
            type = "lua";
			config = builtins.readFile(./nvim/plugin/telescope.lua);
		}

		{
			plugin = (nvim-treesitter.withPlugins (p: [
				p.tree-sitter-nix
				p.tree-sitter-vim
				p.tree-sitter-bash
				p.tree-sitter-lua
				p.tree-sitter-python
				p.tree-sitter-json
				p.tree-sitter-rust
				p.tree-sitter-c
                p.tree-sitter-go
			]));
            type = "lua";
			config = builtins.readFile(./nvim/plugin/treesitter.lua);
		}

        {
          plugin = kanagawa-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/plugin/kanagawa.lua);
        }

        {
          plugin = alpha-nvim;
          type = "lua";
          config = builtins.readFile(./nvim/plugin/alpha.lua);
        }

		vim-nix
		
		neodev-nvim
		
		# telescope-fzf-native-nvim # unused
		
		cmp_luasnip

		cmp-nvim-lsp
		
		luasnip

		friendly-snippets
		
		nvim-web-devicons

        playground # treesitter playground
	];

	extraLuaConfig = builtins.readFile ./nvim/init.lua;

  };



  # programs.gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome.gnome-themes-extra;
  #   };
  # };
  #
  # programs.qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };



  colorScheme = {
  	slug = "corvine";
	name = "Corvine";
	author = "arzg (https://ithub.com/arzg/vim-corvine)";
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
