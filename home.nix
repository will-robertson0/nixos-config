{ config, pkgs, inputs, ... }:

{
  imports = [
      inputs.home-manager.nixosModules.default
	  ./features/mako.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.everforest;

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
	settings = {
		background_opacity = "0.8";
		confirm_os_window_close = 0;
		scrollback_lines = "10000";
		window_padding_width = 8;
		# something about shell_integration no-rc
	};
  };



  # neovim
  programs.neovim = {
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

		nvim-colorizer-lua
	];
  };



}
