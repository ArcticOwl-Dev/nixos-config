{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "remote-touchpad";
  version = "master";

  src = fetchFromGitHub {
    owner = "ArcticOwl-Dev";
    repo = "remote-touchpad";
    rev = "refs/heads/master";
    hash = "sha256-yOLd+3Ht0eI01EqZ1fYKCOsS7hNS0KU/tpOVx3X7gcA=";
  };

  # Wayland-only build (portal + uinput)
  tags = [ "portal" "uinput" ];

  vendorHash = "sha256-nkzvE59H7adyzveXYFI1NVwIh8chBRrVZZKfLY0fEaw=";

  meta = with lib; {
    description = "Control mouse and keyboard from a smartphone or tablet";
    homepage = "https://github.com/ArcticOwl-Dev/remote-touchpad";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

