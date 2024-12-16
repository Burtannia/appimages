{ lib, appimageTools, fetchzip, ... }:

let
  pname = "openrgb-pipeline";
  version = "pipeline";

  zip = fetchzip {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/download?job=Linux%20amd64%20AppImage";
    hash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
  };

  src = readFile $out/OpenRGB-x86_64.AppImage;
  # udevRules = $out/60-openrgb.rules;

  appimageContents = appimageTools.extractType1 { inherit pname version src; };

  mkDesktop = import ./desktop-helper.nix;
    # boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  
  # services.udev.extraRules =  builtins.readFile openrgb-rules;
in appimageTools.wrapType1 {
  inherit pname version src;
 
  # Setup Desktop Entry
  extraInstallCommands = mkDesktop { inherit pname; inherit appimageContents; };

  meta = with lib; {
    description = "Pipeline version of OpenRGB";
    longDescription = ''
      One of the biggest complaints about RGB is the software ecosystem surrounding it.
      Every manufacturer has their own app, their own brand, their own style. If you want
      to mix and match devices, you end up with a ton of conflicting, functionally identical
      apps competing for your background resources. On top of that, these apps are proprietary
      and Windows-only. Some even require online accounts. What if there was a way to control
      all of your RGB devices from a single app, on both Windows and Linux, without any
      nonsense? That is what OpenRGB sets out to achieve. One app to rule them all.
    '';
    mainProgram = "openrgb";
    homepage = "https://openrgb.org";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ burtannia ];
    platforms = platforms.linux;
  };
}
