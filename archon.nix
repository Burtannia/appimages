{ lib, appimageTools, fetchurl, ... }:

let
  pname = "archon";
  version = "9.0.113";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-archon/releases/download/v${version}/archon-v${version}.AppImage";
    hash = "sha256-B4HFUkZjNOlT7M8C/eWg99KfNnZ2dwA3omInYNCNZ08=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
in appimageTools.wrapType2 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop {
    inherit pname;
    inherit appimageContents;
    desktopFile = "Archon App.desktop";
  };
}
