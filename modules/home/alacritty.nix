{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        decorations = "none";
        opacity = 0.9;
        startup_mode = "Fullscreen";
      };
    };
  };
}
