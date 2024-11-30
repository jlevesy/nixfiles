{...}: {
  xdg.configFile."waybar/scripts/executable_conn_status.sh" = {
    source = ./waybar/scripts/executable_conn_status.sh;
  };

  programs.waybar = {
    enable = true;
    style = ./waybar/style.css;
    settings = {
      bar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [];
        modules-right = [
          "tray"
          "custom/vpn"
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "power-profiles-daemon"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scrol = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
          };
        };

        tray = {
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{load} {usage}% ";
          interval = 5;
          tooltip = false;
        };
        memory = {
          interval = 5;
          format = "{used:0.1f}G/{total:0.1f}G ";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        network = {
          format-wifi = "  {essid}   {bandwidthDownBytes}   {bandwidthUpBytes}";
          format-ethernet = "  {ifname}   {bandwidthDownBytes}   {bandwidthUpBytes}";
          format-linked = " (No IP)";
          format-disconnected = "";
          on-click = "alacritty -e nmtui";
          tooltip = false;
          interval = 5;
        };
        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        "custom/vpn" = {
          format = "{icon} ";
          tooltip-format = "{icon} ";
          exec = "$HOME/.config/waybar/scripts/conn_status.sh urcloud.cc";
          return-type = "json";
          interval = 5;
          format-icons = ["" ""];
        };
      };
    };
  };
}
