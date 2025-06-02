{
  description = "Default Home Manager configuration for Sodalite"

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    {nixpkgs, home-manager, hyprland, ...}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."user@hostname" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            wayland.windowManager.hyprland = {
              enable = true;
              package = null;
              portalPackage = null;
            };
          }
          ./home.nix
        ];
      };
    };
}
