{...}: {
  programs.wofi = {
    enable = true;

    style = builtins.readFile ./wofi/style.css;
  };
}
