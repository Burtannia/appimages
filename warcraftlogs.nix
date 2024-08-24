{ lib, appimageTools, fetchurl, ... }:

let
  pname = "warcraftlogs";
  version = "8.12.39";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v8.12.39/warcraftlogs-v8.12.39.AppImage";
    hash = "sha256-aL56ukDCqu80FXnENNYkp341cNwX1ZTo2O2ZhrOz5dU=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
in appimageTools.wrapType1 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop { inherit pname; inherit appimageContents; };

  meta = with lib; {
    description = "World of Warcraft WarcraftLogs uploader";
    longDescription = ''
      In order to upload log files to warcraftlogs.com, you need to install a desktop app.
      The Uploader app is a standalone application for uploading log files. 
    '';

    mainProgram = "warcraftlogs";
    homepage = "https://www.warcraftlogs.com";
    downloadPage = "https://github.com/RPGLogs/Uploaders-warcraftlogs/releases";
    license = licenses.unfree;
    maintainers = with maintainers; [ burtannia ];
    platforms = [ "x86_64-linux" ];
  };
}
