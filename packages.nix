# this file is autogenerated by .github/workflows/update.yml
{
  x86_64-linux.database = builtins.fetchurl {
    url = "https://github.com/Mic92/nix-index-database/releases/download/2022-12-25/index-x86_64-linux";
    sha256 = "0729116979a3g89q57jz5qc2nnlacv3wr6x80wmdhcgfji8dmcv3";
  };
  x86_64-darwin.database = builtins.fetchurl {
    url = "https://github.com/Mic92/nix-index-database/releases/download/2022-12-25/index-x86_64-darwin";
    sha256 = "09xm7ds6i86a46d7b511hi1b1657phmpx36psw5v8zcb2cp3yvyf";
   };
  aarch64-linux.database = builtins.fetchurl {
    url = "https://github.com/Mic92/nix-index-database/releases/download/2022-12-25/index-aarch64-linux";
    sha256 = "0q8g6h5qfk0a9b1ix39c0aj7f763fys4sgk59f18mgkgnpvi2j48";
  };
}