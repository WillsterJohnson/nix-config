{
  lib,
  stdenv,
  fetchurl,
  nixosTests,
  copyDesktopItems,
  makeDesktopItem,
  makeWrapper,
  wrapGAppsHook3,
  gobject-introspection,
  jre,
  xorg,
  zlib,
  nss,
  nspr,
  fontconfig,
  pango,
  cairo,
  expat,
  alsa-lib,
  cups,
  dbus,
  atk,
  gtk3-x11,
  gtk2-x11,
  gdk-pixbuf,
  libGL,
  glib,
  curl,
  freetype,
  libpulseaudio,
  libuuid,
  systemd,
  flite ? null,
  libXxf86vm ? null,
}: let
  desktopItem = makeDesktopItem {
    name = "minecraft";
    exec = "minecraft";
    icon = "minecraft";
    comment = "Official launcher for Minecraft, a sandbox-building game";
    desktopName = "Minecraft";
    categories = ["Game"];
  };

  envLibPath = lib.makeLibraryPath [
    curl
    libpulseaudio
    systemd
    alsa-lib # needed for narrator
    flite # needed for narrator
    libXxf86vm # needed only for versions <1.13
    libGL
  ];

  libPath = lib.makeLibraryPath ([
      alsa-lib
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3-x11
      gtk2-x11
      libuuid
      nspr
      nss
      pango
      stdenv.cc.cc
      zlib
    ]
    ++ (with xorg; [
      libX11
      libxcb
      libXcomposite
      libXcursor
      libXdamage
      libXext
      libXfixes
      libXi
      libXrandr
      libXrender
      libXtst
      libXScrnSaver
    ]));
in
  stdenv.mkDerivation rec {
    pname = "minecraft";

    version = "2.2.1441";

    src = fetchurl {
      url = "https://launcher.mojang.com/download/linux/x86_64/minecraft-launcher_${version}.tar.gz";
      sha256 = "03q579hvxnsh7d00j6lmfh53rixdpf33xb5zlz7659pvb9j5w0cm";
    };

    icon = fetchurl {
      url = "https://launcher.mojang.com/download/minecraft-launcher.svg";
      sha256 = "0w8z21ml79kblv20wh5lz037g130pxkgs8ll9s3bi94zn2pbrhim";
    };

    nativeBuildInputs = [makeWrapper wrapGAppsHook3 copyDesktopItems gobject-introspection];

    sourceRoot = ".";

    dontWrapGApps = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/opt
      mv minecraft-launcher $out/opt/
      mv $out/opt/minecraft-launcher $out/opt/minecraft
      mv $out/opt/minecraft/minecraft-launcher $out/opt/minecraft/minecraft

      install -D $icon $out/share/icons/hicolor/symbolic/apps/minecraft.svg

      runHook postInstall
    '';

    preFixup = ''
      patchelf \
        --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        --set-rpath '$ORIGIN/'":${libPath}" \
        $out/opt/minecraft/minecraft
      patchelf \
        --set-rpath '$ORIGIN/'":${libPath}" \
        $out/opt/minecraft/libcef.so
      patchelf \
        --set-rpath '$ORIGIN/'":${libPath}" \
        $out/opt/minecraft/liblauncher.so
    '';

    postFixup = ''
      # Do not create `GPUCache` in current directory
      makeWrapper $out/opt/minecraft/minecraft $out/bin/minecraft \
        --prefix LD_LIBRARY_PATH : ${envLibPath} \
        --prefix PATH : ${lib.makeBinPath [jre]} \
        --set JAVA_HOME ${lib.getBin jre} \
        --chdir /tmp \
        "''${gappsWrapperArgs[@]}"
    '';

    desktopItems = [desktopItem];

    meta = with lib; {
      description = "Official launcher for Minecraft, a sandbox-building game";
      homepage = "https://minecraft.net";
      maintainers = with maintainers; [willsterjohnson];
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
    };
  }
