{ config, pkgs, ... }:

{

  home.username = "user@hostname";
  home.homeDirectory = "/home/user@hostname";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

   wayland.windowManager.hyprland.settings = {
     "$mod" = "SUPER";
     "$terminal" = "ghostty";
     bind =
       [
         "$mod, Q, exec, $terminal"
         "$mod, C, killactive,"
         "$mod, M, exit,"
         "$mod, V, togglefloating,"
         "$mod, left, movefocus, l"
         "$mod, right, movefocus, r"
         "$mod, up, movefocus, u"
         "$mod, down, movefocus, d"
       ]
       ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
       );
   };
}
