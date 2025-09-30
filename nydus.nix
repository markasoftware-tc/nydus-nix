{ cmake, perl, fetchFromGitHub, rustPlatform }:

# to update: Bump the version, then wait for the first hash failure, replace that in fetchFromGitHub, then run again, and put the hash in cargoHash
rustPlatform.buildRustPackage rec {
  pname = "nydus";
  version = "2.3.7";
  nativeBuildInputs = [
    cmake
    perl
  ];
  src = fetchFromGitHub {
    owner = "dragonflyoss";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-dVPfxsM/mduCopc2t+60+MDO98DRYvpNB+9/gUoXTSc=";
  };
  cargoHash = "sha256-RH7Oa/C29br9GJk4cAMYYS5L5DQlZ9LffYl7RNdxwmU=";
}
