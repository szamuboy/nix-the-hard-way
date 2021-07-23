{ pkgs ? import <nixpkgs> {},
  stable-pkgs ? import <nixpkgs-stable> {},
}:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.nixops ];
    # AWS_SHARED_CREDENTIALS_FILE = "/home/gergely/walls/CI/Walls.io-Actions/eks/aws_credentials";
    # NIXOPS_DEPLOYMENT = "nix.gesz.dev";
    NIXOPS_STATE = "${ builtins.toString ./.nixops/deployments.nixops }";
  }
