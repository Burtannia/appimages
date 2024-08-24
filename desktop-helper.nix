{ appimageContents, pname }:
''
  install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
  substituteInPlace $out/share/applications/${pname}.desktop \
    --replace 'Exec=AppRun' 'Exec=${pname}'
  cp -r ${appimageContents}/usr/share/icons $out/share
''
