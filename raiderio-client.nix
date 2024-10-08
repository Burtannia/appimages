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

  meta = with lib; {
    description = "World of Warcraft RaiderIO client";
    longDescription = ''
      The Raider.IO App is the World of Warcraft player's best tool to organize and track their Characters,
      Mythic+ Dungeons, and Raid Progress. It is the combination of the well-known and established
      Raider.IO AddOn (over 300 million downloads!) and the Raider.IO Client.
    '';

    mainProgram = "raiderio-client";
    homepage = "https://raider.io/addon";
    downloadPage = "https://github.com/RaiderIO/raiderio-client-builds/releases";
    license = licenses.unfree;
    maintainers = with maintainers; [ burtannia ];
    platforms = [ "x86_64-linux" ];
  };
}
