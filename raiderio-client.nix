{ lib, appimageTools, fetchurl, ... }:

let
  pname = "raiderio-client";
  version = "4.10.7";

  src = fetchurl {
    url = "https://github.com/RaiderIO/raiderio-client-builds/releases/download/v${version}/RaiderIO_Installer_Linux_x86_64.AppImage";
    hash = "sha256-BXr4wmgnfs+IioMTpZW2rd8ZVxUMt0UFtt4ww5G7Yxo=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
in appimageTools.wrapType2 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop { inherit pname; inherit appimageContents; };
}
