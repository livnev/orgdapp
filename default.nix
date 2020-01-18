{ stdenv, lib, makeWrapper, emacsWithPackages }:

let
  emacs-with-stuff = emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    htmlize
    projectile
    solarized-theme
  ]));
in
stdenv.mkDerivation {
  pname = "orgdapp";
  version = "0.1";
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ emacs-with-stuff ];
  src = ./.;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
    install bin/* $out/bin;
  '';
  postFixup = let path = lib.makeBinPath [ emacs-with-stuff ]; in ''
    for prog in "$out"/bin/orgdapp-*; do
      wrapProgram "$prog" --prefix PATH ":" "${path}"
    done
  '';
}
