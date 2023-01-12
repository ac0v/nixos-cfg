{ lib, stdenv, fetchurl, makeDesktopItem, copyDesktopItems, dpkg, glib, glibc, gcc-unwrapped, autoPatchelfHook, webkitgtk, p11-kit, lttng-ust, krb5, gtk3, openssl, gdk-pixbuf, librsvg, paper-icon-theme, gsettings-desktop-schemas, makeWrapper, wrapGAppsHook, gio-sharp, dotnet-sdk, mesa, libGL, icu }:
let

  version = "2022.3.0.8";
  src = fetchurl {
    url = "https://cdn.devolutions.net/download/Linux/RDM/${version}/RemoteDesktopManager_${version}_amd64.deb";
    sha256 = "a706d2eca273ce3ef557bf8a57240fabfa00793b34777f70e28a1ec66c568fd8";
  };
#  pkgs_glib = import (builtins.fetchGit {
#    name = "nixpkgs-with-glib-0.13.8.2";
#    url = "https://github.com/NixOS/nixpkgs/";
##    ref = "refs/heads/nixpkgs-unstable";
##    rev = "ee01de29d2f58d56b1be4ae24c24bd91c5380cea";
#    ref = "refs/heads/master";
#    rev = "3bf436238189e8acf6044dd16e1cf705cffe30ee";
#  }) {};

in stdenv.mkDerivation rec {
  name = "remotedesktopmanager-${version}";
  system = "x86_64-linux";

  inherit src;

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
    makeWrapper
  ];

  buildInputs = [
    glibc
    gcc-unwrapped
    webkitgtk
    p11-kit
#    pkgs_glib.buildPackages.glib
#    pkgs_glib.glib
    glib
    lttng-ust
    krb5
    gtk3
    openssl
    gdk-pixbuf
    librsvg
    paper-icon-theme
    gsettings-desktop-schemas
    wrapGAppsHook
    gio-sharp
    dotnet-sdk
    mesa
    libGL
    icu
  ];

  unpackPhase = "true";

  installPhase = ''
    dpkg-deb -X $src $out
    substituteInPlace $out/bin/remotedesktopmanager \
        --replace /usr/lib/ $out/usr/lib/

    patchelf --replace-needed liblttng-ust.so.0 liblttng-ust.so.1 $out/usr/lib/devolutions/RemoteDesktopManager/libcoreclrtraceptprovider.so
    ln -s $out/usr/lib/devolutions/RemoteDesktopManager/lib/libWebView.so $out/usr/lib/devolutions/RemoteDesktopManager/lib/libWebView.so.so
#    patchelf --replace-needed tls/radeonsi_dri.so radeonsi_dri.so $out/usr/lib/devolutions/RemoteDesktopManager/RemoteDesktopManager

#    patchelf --add-needed libgtk-3.so.0 $out/usr/lib/devolutions/RemoteDesktopManager/RemoteDesktopManager
##    patchelf --replace-needed $out/usr/lib/devolutions/RemoteDesktopManager/
#    # patchelf --replace-needed $out/usr/lib/devolutions/RemoteDesktopManager/libcoreclr.so

    find $out -type f -name '*.so' -exec patchelf --set-rpath "${lib.makeLibraryPath buildInputs}" {} \;
#    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:/run/opengl-driver/lib/dri/" $out/usr/lib/devolutions/RemoteDesktopManager/RemoteDesktopManager

    mkdir $out/workaround
    ln -s /run/opengl-driver/lib/dri $out/workaround/tls

#    rm $out/usr/lib/devolutions/RemoteDesktopManager/libcoreclr.so
#    ln -s /nix/store/cqk249kfy40fzbvfjns66z2p636ihr93-dotnet-sdk-6.0.402/shared/Microsoft.NETCore.App/6.0.10/libcoreclr.so $out/usr/lib/devolutions/RemoteDesktopManager/libcoreclr.so

    wrapProgram $out/bin/remotedesktopmanager \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs} \
      --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
      --set LIBGL_DRIVERS_PATH "$out/workaround/"

    chmod 755 $out
  '';

  meta = {
    description = "Devolutions Remote Desktop Manager Enterprise centralizes all remote connections on a single platform that is securely shared between users and across the entire team.";
    homepage = "https://remotedesktopmanager.com/";
    license = lib.licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
