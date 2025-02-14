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
    # find these .desktop files with ls -l /run/current-system/sw/share/applications/
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
        st = "status";
        ad = "add .";
	};
  };


  
  # kitty!
  programs.kitty = {
  	enable = true;
    # theme = "Corvine"; # select from kitty +kitten themes
    shellIntegration.enableFishIntegration = true;
	settings = {
		background_opacity = "0.98"; # 0.84
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
    extraConfig = "include ~/nixos/media/kanagawa-dragon.conf\n";
  };



  # sway
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    # xwayland = true; # will uncomment this when i run into issues. supposedly "needed for the default configuration of sway."
    checkConfig = false; # had to do this to fix wallpaper image not being found

    config = rec {

      modifier = "Mod4";
      terminal = "kitty"; 
      menu = "rofi -show drun";

      startup = [
        { command = "nm-applet --indicator"; }
        { command = "mako"; }
        # { command = "killall -q waybar"; always = true; }
        # { command = "waybar -c ~/.config/waybar/config_vertical -s ~/.config/waybar/style_vertical.css"; always = true; }
      ];

      bars = [{command = "waybar -c ~/.config/waybar/config_vertical -s ~/.config/waybar/style_vertical.css";}];

      gaps = {
        outer = 4;
        inner = 3;
      };

      input = {
        "1133:16500:Logitech_G305" = {
          accel_profile = "flat";
          pointer_accel = "0.05";
        };
      };

      output = {
        DP-2 = {
          mode = "1920x1080@239.760Hz";
          pos = "0 0";
          bg = "/home/wjr/nixos/media/doorofperception.com-hiro_isono-header.jpg fill";
        };
        HDMI-A-1 = {
          mode = "1920x1080@60Hz";
          pos = "1920 0";
          bg = "/home/wjr/nixos/media/doorofperception.com-hiro_isono-header.jpg fill";
        };
      };

      workspaceOutputAssign = [
        {
          output = "HDMI-A-1";
          workspace = "2";
        }
      ];

      window = {
        titlebar = false;
        border = 1;
      };

      floating.titlebar = false;

      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+q" = "kill";

        "${mod}+a" = "splith";
        "${mod}+w" = "splitv";

        "${mod}+space" = "floating toggle";

        "${mod}+Shift+s" = "exec grim -l 0 -g \"$(slurp)\" - | wl-copy -t image/png";
        
        "${mod}+Shift+0" = "move container to workspace number 10; workspace number 10";
        "${mod}+Shift+1" = "move container to workspace number 1; workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2; workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3; workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4; workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5; workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6; workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7; workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8; workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9; workspace number 9";

        "${mod}+Control+l" = "resize shrink width 10 px";
        "${mod}+Control+k" = "resize grow height 10 px";
        "${mod}+Control+j" = "resize shrink height 10 px";
        "${mod}+Control+h" = "resize grow width 10 px";
      };

# "#181616", "#C4746E", "#8A9A7B", "#C4B28A",
# "#8BA4B0", "#A292A3", "#8EA4A2", "#C8C093",
# "#A6A69C", "#E46876", "#87A987", "#E6C384",
# "#7FB4CA", "#938AA9", "#7AA89F", "#C5C9C5"

      colors = {
        focused = {
          background = "#181616";
          border = "#8A9A7B";
          childBorder = "#87A987";
          indicator = "#87A987";
          text = "#A6A69C";
        };
        focusedInactive = {
          background = "#181616";
          border = "#5f676a";
          childBorder = "#595959";
          indicator = "#595959";
          text = "#5f676a";
        };
        unfocused = {
          background = "#181616";
          border = "#222222";
          childBorder = "#595959";
          indicator = "#595959";
          text = "#222222";
        };
        urgent = {
          background = "#181616";
          border = "#E46876";
          childBorder = "#E46876";
          indicator = "#E46876";
          text = "#E46876";
        };
        placeholder = {
          background = "#000000";
          border = "#0c0c0c";
          childBorder = "#ffffff";
          indicator = "#ffffff";
          text = "#0c0c0c";
        };
        background = "#181616";
      };

    };
  };

  services.gnome-keyring.enable = true;

  # kanshi systemd service (from wiki.nixos.org/wiki/Sway)
  systemd.user.services.kanshi = {
    # description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY="wayland-1";
      DISPLAY = ":0";
    }; 
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
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
		base00 = "#181616"; # bg0 -- used to be 3a3a3a
		base01 = "#C4746E";
		base02 = "#8A9A7B";
		base03 = "#C4B28A";
		base04 = "#8BA4B0";
		base05 = "#A292A3";
		base06 = "#8EA4A2";
		base07 = "#C8C093";
		base08 = "#A6A69C";
		base09 = "#E46876";
		base0A = "#87A987";
		base0B = "#E6C384";
		base0C = "#7FB4CA";
		base0D = "#938AA9";
		base0E = "#7AA89F";
		base0F = "#C5C9C5";
	};
  };
}

# kanagawa-dragon
# "#181616",
# "#C4746E",
# "#8A9A7B",
# "#C4B28A",
# "#8BA4B0",
# "#A292A3",
# "#8EA4A2",
# "#C8C093",
# "#A6A69C",
# "#E46876",
# "#87A987",
# "#E6C384",
# "#7FB4CA",
# "#938AA9",
# "#7AA89F",
# "#C5C9C5"

# corvine, edited
# "#262626";
# "#d78787";
# "#87af5f";
# "#d7d7af";
# "#87afd7";
# "#afafd7";
# "#87d7d7";
# "#c6c6c6";
# "#626262";
# "#ffafaf";
# "#afd787";
# "#d7d787";
# "#87d7ff";
# "#d7afd7";
# "#5fd7d7";
# "#eeeeee";
