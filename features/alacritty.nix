{ config, pkgs, ... }:

{
  programs.alacritty = 
  {
    enable = true;

    settings = {

      shell = "fish";

      window = {
        blur = true;
        opacity = 0.84;
        # padding = { x = 8; y = 8; };
        dynamic_padding = true;
      };

      font = {
        normal.family = "JuliaMono";
        normal.style = "Regular";
        bold.style = "Bold";
        italic.style = "RegularItalic";
      };

      colors = {
        primary = {
          background = "#${config.colorScheme.palette.base00}";
          foreground = "#c6c6c6";
        };
        normal = {
          black =   "#3a3a3a";
          red =     "#${config.colorScheme.palette.base01}";
          green =   "#${config.colorScheme.palette.base02}";
          yellow =  "#${config.colorScheme.palette.base03}";
          blue =    "#${config.colorScheme.palette.base04}";
          magenta = "#${config.colorScheme.palette.base05}";
          cyan =    "#${config.colorScheme.palette.base06}";
          white =   "#${config.colorScheme.palette.base07}";
        };

        bright = {
          black =   "#${config.colorScheme.palette.base08}";
          red =     "#${config.colorScheme.palette.base09}";
          green =   "#${config.colorScheme.palette.base0A}";
          yellow =  "#${config.colorScheme.palette.base0B}";
          blue =    "#${config.colorScheme.palette.base0C}";
          magenta = "#${config.colorScheme.palette.base0D}";
          cyan =    "#${config.colorScheme.palette.base0E}";
          white =   "#${config.colorScheme.palette.base0F}";
        };

      };
    };
  }; 
}
