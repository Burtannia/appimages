{ lib, appimageTools, fetchurl, ... }:

let
  pname = "raiderio-client";
  version = "4.10.7";

  src = fetchurl {
    url = "https://github.com/RaiderIO/raiderio-client-builds/releases/download/v${version}/RaiderIO_Installer_Linux_x86_64.AppImage";
    hash = "sha256-6YkX4DUZLK1F0hP36FGmH3lyDITqjTwyfq9Aqinqi7A=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
in appimageTools.wrapType2 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop { inherit pname; inherit appimageContents; };
}
