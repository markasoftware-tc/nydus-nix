{ makeBinaryWrapper, lib, nydus, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "nydus-snapshotter";
  version = "v0.15.10";
  nativeBuildInputs = [ makeBinaryWrapper ];
  # weird docker crap
  doCheck = false;
  src = fetchFromGitHub {
    owner = "containerd";
    repo = pname;
    rev = version;
    hash = "sha256-XA8cBXu4HhPp6kUsJ6eD4M6vg6SKYI8oFxPdFIZXgzM=";
  };
  vendorHash = "sha256-F69jfizfXt9cgAE7/xfMRjWnba+cl0ej0XmibRGEuDI=";
  postInstall = ''
    wrapProgram $out/bin/containerd-nydus-grpc --prefix PATH : ${lib.makeBinPath [ nydus ] }
  '';
}
