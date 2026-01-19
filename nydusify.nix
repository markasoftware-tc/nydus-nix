{ lib, fetchFromGitHub, buildGoModule, runCommand, makeBinaryWrapper, nydus }:

# to update: Bump the version, then wait for the first hash failure, replace that in fetchFromGitHub, then run again, and put the hash in cargoHash
buildGoModule rec {
  pname = "nydusify";
  version = "2.4.0";
  nativeBuildInputs = [ makeBinaryWrapper ];
  src = fetchFromGitHub {
    owner = "dragonflyoss";
    repo = "nydus";
    rev = "v${version}";
    hash = "sha256-bTOh1Lb9hTTYlMc+XqGxvAX6TDA4p2xbqQc5tWJsUhs=";
  } + "/contrib/nydusify";
  vendorHash = "sha256-HNDfzhX6MJEyOCeHj2+TYdhSMC2aKU4ZTju6M55E7Ds=";
  postInstall = ''
    makeWrapper $out/bin/cmd $out/bin/nydusify --prefix PATH : ${lib.makeBinPath [ nydus ] }
    mv $out/bin/plugin $out/bin/nydusify-plugin
  '';
}
