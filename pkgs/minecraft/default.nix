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
    libXxf86vm
    libGL
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
  ];

  libPath = lib.makeLibraryPath ([
      # grep launcher_log.txt for 'java.lang.UnsatisfiedLinkError'
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

  linuxJson = builtins.fromJSON (builtins.readFile (
    fetchurl {
      url = "https://launchermeta.mojang.com/v1/products/launcher/6f083b80d5e6fabbc4236f81d0d8f8a350c665a9/linux.json";
      sha256 = "sha256-qqd9UEKGmxr7KpWpO74yak4BqgsgcL/5FAQiJk9yJAo=";
    }
  ));
in
  stdenv.mkDerivation rec {
    pname = "minecraft";

    version = (builtins.elemAt linuxJson.launcher-core 0).version.name;

    src = fetchurl {
      url = "https://launcher.mojang.com/download/Minecraft.tar.gz";
      sha256 = "sha256-aVJpKBVHu7z0f+dGMwJ6Dk3cE6YQYMaGpyF+hdMU5F4=";
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

      mkdir -p $out/opt/minecraft
      mv minecraft-launcher/minecraft-launcher $out/opt/minecraft/minecraft

      install -D $icon $out/share/icons/hicolor/symbolic/apps/minecraft.svg

      runHook postInstall
    '';

    preFixup = ''
      patchelf \
        --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        --set-rpath '$ORIGIN/'":${libPath}" \
        $out/opt/minecraft/minecraft
    '';

    postFixup = ''
      # Do not create `GPUCache` in current directory
      makeWrapper $out/opt/minecraft/minecraft $out/bin/minecraft \
        --prefix LD_LIBRARY_PATH : ${envLibPath} \
        --prefix PATH : ${lib.makeBinPath [jre]} \
        --set JAVA_HOME ${lib.getBin jre} \
        --chdir /tmp
    '';
    # "''${gappsWrapperArgs[@]}"

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
