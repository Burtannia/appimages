{ lib, appimageTools, fetchurl, ... }:

let
  pname = "runekit";
  version = "1";

  src = fetchurl {
    url = "https://github.com/whs/runekit/releases/download/continuous/RuneKit.AppImage";
    hash = "sha256-pahLgQaYyfv0fYpCfehfee5RlyC0WwgadDIvn0Z6nn8=";
  };

in appimageTools.wrapType1 {
  inherit pname version src;
 
  meta = with lib; {
    description = "Alt1-compatible toolbox for RuneScape 3, for Linux and macOS.";
    mainProgram = "runekit";
    homepage = "https://github.com/whs/runekit";
    downloadPage = "https://github.com/whs/runekit/releases";
    license = licenses.free;
    maintainers = with maintainers; [ burtannia ];
    platforms = [ "x86_64-linux" ];
  };
}
