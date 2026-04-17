{ appimageContents, pname, desktopFile ? "${pname}.desktop" }:
''
  install -m 444 -D ${appimageContents}/'${desktopFile}' -t $out/share/applications
  substituteInPlace $out/share/applications/'${desktopFile}' \
    --replace 'Exec=AppRun' 'Exec=${pname}'
  cp -r ${appimageContents}/usr/share/icons $out/share
''
