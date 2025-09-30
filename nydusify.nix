{ lib, fetchFromGitHub, buildGoModule, runCommand, makeBinaryWrapper, nydus }:

# to update: Bump the version, then wait for the first hash failure, replace that in fetchFromGitHub, then run again, and put the hash in cargoHash
buildGoModule rec {
  pname = "nydusify";
  version = "2.3.7";
  nativeBuildInputs = [ makeBinaryWrapper ];
  src = fetchFromGitHub {
    owner = "dragonflyoss";
    repo = "nydus";
    rev = "v${version}";
    hash = "sha256-dVPfxsM/mduCopc2t+60+MDO98DRYvpNB+9/gUoXTSc=";
  } + "/contrib/nydusify";
  vendorHash = "sha256-SmDOmCMinTg72P8n4c1HnwKpt/CVeIlqdFcp5LHm2tA=";
  postInstall = ''
    makeWrapper $out/bin/cmd $out/bin/nydusify --prefix PATH : ${lib.makeBinPath [ nydus ] }
    mv $out/bin/plugin $out/bin/nydusify-plugin
  '';
}
