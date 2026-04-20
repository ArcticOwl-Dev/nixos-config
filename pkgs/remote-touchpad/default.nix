{ lib
, buildGoModule
, src
}:

buildGoModule {
  pname = "remote-touchpad";
  version = "unstable";

  inherit src;

  # Wayland-only build (portal + uinput)
  tags = [ "portal" "uinput" ];

  vendorHash = "sha256-aI1b63xBr685zU5C200H9IudP6GyBn5gio1srgY9llc=";

  meta = with lib; {
    description = "Control mouse and keyboard from a smartphone or tablet";
    homepage = "https://github.com/ArcticOwl-Dev/remote-touchpad";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

