self:
{ lib, pkgs, config, ... }:
{
  options = {
    programs.nix-index.symlinkToCacheHome = lib.mkOption {
      type = lib.types.bool;
      default = config.programs.nix-index.enable;
      description = ''
        Whether to symlink the prebuilt nix-index database to the default
        location used by nix-index. Useful for tools like comma.
      '';
    };
    programs.nix-index-database.comma.enable = lib.mkEnableOption "wrapping comma with nix-index-database and put it in the PATH";
  };
  config = {
    programs.nix-index = {
      enable = lib.mkDefault true;
      package = lib.mkDefault self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nix-index-with-db;
    };
    home.packages = lib.optional config.programs.nix-index-database.comma.enable self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.comma-with-db;

    home.file."${config.xdg.cacheHome}/nix-index/files" =
      lib.mkIf config.programs.nix-index.symlinkToCacheHome
        { source = self.legacyPackages.${pkgs.stdenv.system}.database; };
  };
  _file = ./darwin-module.nix;
}
