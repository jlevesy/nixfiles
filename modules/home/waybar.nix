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
          "custom/separator"
          "hyprland/window"
        ];
        modules-center = [];
        modules-right = [
          "tray"
          "custom/separator"
          "idle_inhibitor"
          "custom/separator"
          "network"
          "custom/separator"
          "cpu"
          "custom/separator"
          "memory"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "power-profiles-daemon"
          "battery"
          "custom/separator"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scrol = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = " ";
            "6" = " ";
            "7" = " ";
            "8" = " ";
            "9" = " ";
            "10" = " ";
          };
        };

        "custom/separator" = {
          format = "|";
          tooltip = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        tray = {
          spacing = 4;
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
        };
        cpu = {
          format = "{load} {usage}%  ";
          interval = 5;
          tooltip = false;
        };
        memory = {
          interval = 5;
          format = "{used:0.1f}G/{total:0.1f}G  ";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}%  ";
          format-alt = "{time} {icon}";
          format-icons = [" " " " " " " " " "];
        };
        network = {
          format-wifi = "  {essid}   {bandwidthDownBytes}   {bandwidthUpBytes}";
          format-ethernet = "  {ifname}   {bandwidthDownBytes}   {bandwidthUpBytes}";
          format-linked = " (No IP)";
          format-disconnected = " ";
          on-click = "alacritty -e nmtui";
          tooltip = false;
          interval = 5;
        };
        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = " ";
            performance = " ";
            balanced = " ";
            power-saver = " ";
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
      };
    };
  };
}
