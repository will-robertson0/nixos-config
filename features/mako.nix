{ pkgs, config, ... }:

{
	services.mako = {
		enable = true;
		backgroundColor = "#${config.colorScheme.palette.base01}";
		borderColor = "#${config.colorScheme.palette.base0E}";
		borderRadius = 6;
		borderSize = 1;
		textColor = "#${config.colorScheme.palette.base04}";
		layer = "overlay";
		defaultTimeout = 50000;
		margin = "15";
		padding = "15";
	};
}
