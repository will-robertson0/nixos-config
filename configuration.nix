# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # enable sound
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  sound.enable = true;

  # enable sound with pipewire
#  sound.enable = true;
#  security.rtkit.enable = true;
#  services.pipewire = {
#  	enable = true;
#	alsa.enable = true;
#	alsa.support32Bit = true;
#	pulse.enable = true;
#	jack.enable = true;
#  };

  # enable flakes (following vimjoyer vid)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  Variant = "";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wjr = {
    isNormalUser = true;
    description = "wjr";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "wjr";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	neovim
	wget
	neofetch
	firefox
	rofi-wayland
	hyprpaper
	waybar
#	(waybar.overrideAttrs (oldAttrs: {
#		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
#		})
#	)
	dolphin
	pulsemixer
	discord
	vesktop # discord with screensharing with audio on waylandd
	libnotify # for mako
	mako # notification daemon
	btop
    networkmanagerapplet
	grim
	slurp
	wl-clipboard
	rustc
	cargo
	killall
	vscodium
	chromium
	tidal-hifi
	bitwarden
	bitwarden-cli # bw
	vifm-full
	ranger # also a file manager
	floorp # try fastfox
	(callPackage ./thorium-browser.nix {})
	python3
	python311Packages.pip
	git
	gh
	cava
	ripgrep
    fish
    pfetch
  ];



  # fonts
  fonts.packages = with pkgs; [
    iosevka
    material-design-icons
	nerdfonts
  ];



  # home-manager
  home-manager = {
	extraSpecialArgs = { inherit inputs; };
	users = {
		"wjr" = import ./home.nix;
	};
  };



  # hyprland
  programs.hyprland = {
	enable = true;
	#nvidiaPatches = true;
	xwayland.enable = true;
  };
  environment.sessionVariables = {
	# NIXOS_OZONE_WL = "1";
	# if cursor becomes invisible:
	WLR_NO_HARDWARE_CURSORS = "1";
  };
  hardware = {
  	opengl.enable = true;
	# most wayland compositors need this
	nvidia.modesetting.enable = true;
  };



  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # default editor - maybe move this to home.nix?
  environment.variables.EDITOR = "nvim";



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
