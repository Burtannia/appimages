{ lib, appimageTools, fetchurl, ... }:

let
  pname = "raiderio-client";
  version = "4.4.0";

  src = fetchurl {
    url = "https://github.com/RaiderIO/raiderio-client-builds/releases/download/v4.4.0/RaiderIO_Installer_Linux_x86_64.AppImage";
    hash = "sha256-BXr4wmgnfs+IioMTpZW2rd8ZVxUMt0UFtt4ww5G7Yxo=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
in appimageTools.wrapType1 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop { inherit pname; inherit appimageContents; };
}
