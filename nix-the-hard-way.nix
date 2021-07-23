{
  nix =
    { config, pkgs, modulesPath, ... }:
    {
      deployment = {
        targetHost = "nix.gesz.dev";
      };
    };
}
