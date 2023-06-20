{pkgs ? import <nixpkgs> {
  config = {
    allowUnfree = true;
    cudaSupport = true;
  };
} }:
(pkgs.buildFHSUserEnv {
  name = "pytorch";
  targetPkgs = pkgs: (with pkgs; [
    python3Full
    cudaPackages.cudatoolkit
  ]);
  runScript = "bash";
}).env
