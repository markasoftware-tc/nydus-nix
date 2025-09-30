{ makeBinaryWrapper, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "nydus-snapshotter";
  version = "v0.15.4";
  nativeBuildInputs = [ makeBinaryWrapper ];
  # weird docker crap
  doCheck = false;
  src = fetchFromGitHub {
    owner = "containerd";
    repo = pname;
    rev = version;
    hash = "sha256-8Rz9ppaClmmZtMMkDZuQ1YZrXZEwl6ZBHJ5Ju0fpIHc=";
  };
  vendorHash = "sha256-SoZ7yul64Y1a9FFOnrW7V91IGdd021LzFudiFwhVxwA=";
  postInstall = ''
    makeWrapper $out/bin/containerd-nydus-grpc $out/bin/containerd-nydus-grpc --prefix PATH : ${lib.makeBinPath [ nydus ] }
  '';
}
