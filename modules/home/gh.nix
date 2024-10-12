{ pkgs, ... }:

{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";

      alias = {
        co = "pr checkout";
	pv = "pr view";
      };
    };
  };
}
