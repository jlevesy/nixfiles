{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  options = {
    hypr = {
      monitor = lib.mkOption {
        default = [];
        description = ''
          Hyprland monitors to apply
        '';
      };

      wallpaper = lib.mkOption {
        default = [];
        description = ''
          Hyprpaper wallpaper config.
        '';
      };

      wallpaper_preload = lib.mkOption {
        default = "";
        description = ''
          Hyprpaper preload config.
        '';
      };
    };
  };

  config = {
    home.packages = with pkgs; [
      hyprcursor
      wl-clipboard
      grim
      slurp
      cliphist
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];

    xdg.configFile."hypr/wallpaper.png" = {
      source = ./hypr/wallpaper.png;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        "$terminal" = "alacritty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";

        monitor = config.hypr.monitor;

        exec-once = [
          "waybar"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];

        windowrulev2 = [
          "workspace 7, class:^vesktop$"
          "workspace 8, class:^firefox-aurora$"
          "workspace 9, class:^org.keepassxc.KeePassXC$"
          "workspace 10, class:^steam_app_\d+$"
          "workspace 10, class:steam"
          "float, class: ^(steam)$, title:^(?!Steam).*$"
          "minsize 280 635, class: ^(steam)$, title:^(Friends.*)$"
          "suppressevent maximize, class:.*"
        ];

        env = [
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "MOZ_ENABLE_WAYLAND,1"
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "HYPRCURSOR_SIZE,24"
          "XCURSOR_SIZE,24"
        ];

        cursor = {
          no_hardware_cursors = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "grp:alt_space_toggle,compose:rctrl";
          kb_rules = "";

          follow_mouse = 1;

          touchpad = {
            natural_scroll = "no";
            scroll_factor = "0.3";
          };

          sensitivity = "0"; # -1.0 to 1.0, 0 means no modification.
        };

        general = {
          gaps_in = 2;
          gaps_out = 10;
          border_size = 1;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 5;
          blur = {
            enabled = false;
            size = 3;
            passes = 1;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        master = {
          new_status = true;
        };

        gestures = {
          workspace_swipe = "on";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_splash_rendering = 1;
          disable_hyprland_logo = 1;
        };

        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, Return, exec, $terminal"
          "$mainMod, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, B, togglefloating,"
          "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
          "$mainMod, Space, exec, $menu"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, T, togglesplit," # dwindle
          "$mainMod, F, fullscreen,"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Move focus with mainMod + HJKL keys
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          # Moving workspaces on screen
          "ALT $mainMod, H, movecurrentworkspacetomonitor, l"
          "ALT $mainMod, L, movecurrentworkspacetomonitor, r"
          "ALT $mainMod, J, movecurrentworkspacetomonitor, d"
          "ALT $mainMod, K, movecurrentworkspacetomonitor, u"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"

          # Lock screen
          "SUPER, Escape, exec, hyprlock"
          # Print screen
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        # Sound
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;

      settings = {
        background = {
          path = "~/.config/hypr/wallpaper.png";
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        # INPUT FIELD
        input-field = {
          monitor = "";
          size = "400, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgba(235, 219, 178, 1.0)";
          fade_on_empty = "true";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        };

        # TIME
        label = {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M:%S\")\"";
          color = "rgba(235, 219, 178, 1.0)";
          font_size = 120;
          position = "0, -300";
          halign = "center";
          valign = "top";
        };
      };
    };

    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "hyprlock";

          before_sleep_cmd = "hyprlock";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "hyprlock";
          }
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    services.hyprpaper = {
      enable = true;

      settings = {
        preload = config.hypr.wallpaper_preload;
        wallpaper = config.hypr.wallpaper;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
      };
    };
  };
}
