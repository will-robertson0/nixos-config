{ pkgs, config, ... }:

{
	services.mako = {
		enable = true;
		backgroundColor = "#${config.colorScheme.palette.base00}D6";
		borderColor = "#595959aa";
		borderRadius = 6;
		borderSize = 1;
		textColor = "#${config.colorScheme.palette.base0F}";
		layer = "overlay";
		defaultTimeout = 10;
		margin = "15";
		padding = "15";
	};
}
