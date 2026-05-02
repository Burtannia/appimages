{ lib, appimageTools, fetchurl, ... }:

let
  pname = "archon";
  version = "9.0.113";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-archon/releases/download/v${version}/archon-v${version}.AppImage";
    hash = "sha256-B4HFUkZjNOlT7M8C/eWg99KfNnZ2dwA3omInYNCNZ08=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  appName = "Archon App";
in appimageTools.wrapType2 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = ''
    install -m 444 -D '${appimageContents}/${appName}.desktop' -t $out/share/applications
    substituteInPlace $out/share/applications/'${appName}.desktop' \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    install -m 444 -D '${appimageContents}/usr/share/icons/hicolor/512x512/apps/${appName}.png' \
      $out/share/icons/hicolor/512x512/apps/'${appName}'.png
  '';
}
