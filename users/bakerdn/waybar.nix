{
  lib,
  config,
  nix-colors,
  ...
}: {
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 40;

      modules-left = ["sway/workspaces" "sway/mode"];
      modules-center = ["sway/window"];
      modules-right = ["tray" "network" "memory" "cpu" "battery" "backlight" "custom/pipewire" "clock"];

      "sway/window".format = "{}";
      "sway/window".max-length = 50;

      network.format-wifi = "WiFi ({signalStrength}%) {icon}";
      network.format-ethernet = "Ethernet {icon}";
      network.format-linked = "No IP";
      network.format-disconnected = "Disconnected {icon}";
      network.tooltip-format-wifi = "{essid}  {ipaddr}/{cidr}";
      network.tooltip-format-ethernet = "{ifname}  {ipaddr}/{cidr}";
      network.format-icons.wifi = [""];
      network.format-icons.ethernet = [""];
      network.format-icons.disconnected = [""];

      memory.interval = 30;
      memory.format = "{}% ";
      memory.tooltip-format = "{used:0.1f}G/{total:0.1f}G";

      cpu.format = "{usage}% ";

      battery.format-discharging = "{capacity}% {icon}";
      battery.format-charging = "{capacity}% ";
      battery.format-plugged = "{capacity}% ";
      battery.format-icons = ["" "" "" "" "" "" "" "" "" "" ""];
      battery.format-alt = "{time} {icon}";
      battery.states.warning = 30;
      battery.states.critical = 15;

      backlight.device = "intel_backlight";
      backlight.format = "{percent}% {icon}";
      backlight.format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];

      "custom/pipewire".format = "{percentage}% {icon}";
      "custom/pipewire".return-type = "json";
      "custom/pipewire".signal = 8;
      "custom/pipewire".interval = "once";
      "custom/pipewire".format-icons.mute = "ﱝ";
      "custom/pipewire".format-icons.default = ["" "" ""];
      "custom/pipewire".tooltip = false;
      "custom/pipewire".exec = "pw-volume status";

      clock.tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
  };
  programs.waybar.style = let
    inherit (builtins) attrNames attrValues map readFile replaceStrings toString;
    baseNames = attrNames config.colorscheme.colors;
    baseValues = attrValues config.colorscheme.colors;
    baseRGB = map (nix-colors.lib-core.conversions.hexToRGBString ", ") baseValues;
    style = readFile ./style.css;
  in
    replaceStrings baseNames baseRGB style;
}
