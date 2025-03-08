{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # inputs.nvf.packages.${system}.default
    # inputs.nvf.packages.${system}.maximal
  ];

  # imports = [inputs.nvf.homeManagerModules.default];

  # https://github.com/NotAShelf/nvf/blob/main/configuration.nix
  # programs.nvf = {
  #   enable = true;
  #   settings.vim = {
  #     viAlias = false;
  #     vimAlias = true;
  #   };
  # };
}
