# this file is autogenerated by .github/workflows/update.yml
{
  description = "nix-index database";
  outputs = _:
    {
      legacyPackages.x86_64-linux.database = builtins.fetchurl {
        url = "https://github.com/Mic92/nix-index-database/releases/download/2022-06-26/index-x86_64-linux";
        sha256 = "0xwvfv7xjri0v06swqqfx7hrj6g7506h91x8qybg94rpfka3brm8";
      };
      legacyPackages.x86_64-darwin.database = builtins.fetchurl {
        url = "https://github.com/Mic92/nix-index-database/releases/download/2022-06-26/index-x86_64-darwin";
        sha256 = "16xc3j30b484gpwxfwcy9s9y4yj11d5zsax040x6hxg49ajqh6qw";
      };
    };
}