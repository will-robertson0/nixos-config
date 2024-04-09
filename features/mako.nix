{ pkgs, config, ... }:

{
	services.mako = {
		enable = true;
		backgroundColor = "#${config.colorScheme.palette.base00}";
		borderColor = "#${config.colorScheme.palette.base02}";
		borderRadius = 6;
		borderSize = 1;
		textColor = "#${config.colorScheme.palette.base0F}";
		layer = "overlay";
		defaultTimeout = 50000;
		margin = "15";
		padding = "15";
	};
}
