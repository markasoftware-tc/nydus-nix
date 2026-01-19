{ cmake, perl, fetchFromGitHub, rustPlatform }:

# to update: Bump the version, /set hashes to empty strings/, then wait for the first hash failure,
# replace that in fetchFromGitHub, then run again, and put the hash in cargoHash. It's necessary to
# set the hashes to empty strings rather than just leaving them as-is, otherwise instead of actually
# pulling the newer version from github it'll potentially look it up in the cache based on the hash and keep the old version.
rustPlatform.buildRustPackage rec {
  pname = "nydus";
  version = "2.4.0";
  nativeBuildInputs = [
    cmake
    perl
  ];
  src = fetchFromGitHub {
    owner = "dragonflyoss";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-bTOh1Lb9hTTYlMc+XqGxvAX6TDA4p2xbqQc5tWJsUhs=";
  };
  cargoHash = "sha256-TuGiLtyzokZyEC2a7GvJXyez6LINAQyw02BtDAQMrAc=";
}
