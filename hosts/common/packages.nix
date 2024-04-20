{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Auto-upgrade in the background
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };

  environment.systemPackages = (with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    ntfs3g
    dosfstools
    unstable.nh
    nix-output-monitor
    nvd
  ]);

  fonts.packages = with pkgs; [ nerdfonts ];

  environment.sessionVariables = {
    FLAKE = "/home/mike/.dots";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
}