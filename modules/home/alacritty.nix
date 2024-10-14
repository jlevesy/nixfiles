{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      "font.normal" = {
        family = "Inconsolata Nerd Font";
        syte = "Regular";
      };

      window = {
        decorations = "none";
        opacity = 0.9;
        startup_mode = "Fullscreen";
      };
    };
  };
}
