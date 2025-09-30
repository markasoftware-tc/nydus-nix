{ fetchFromGitHub, buildGoModule, runCommand }:

# to update: Bump the version, then wait for the first hash failure, replace that in fetchFromGitHub, then run again, and put the hash in cargoHash
let nydusifyRawPackage = buildGoModule rec {
      pname = "nydusify";
      version = "2.3.7";
      src = fetchFromGitHub {
        owner = "dragonflyoss";
        repo = "nydus";
        rev = "v${version}";
        hash = "sha256-dVPfxsM/mduCopc2t+60+MDO98DRYvpNB+9/gUoXTSc=";
      } + "/contrib/nydusify";
      vendorHash = "sha256-SmDOmCMinTg72P8n4c1HnwKpt/CVeIlqdFcp5LHm2tA=";
    }; in
runCommand "nydusify" {} ''
  mkdir -p $out/bin
  cp ${nydusifyRawPackage}/bin/cmd $out/bin/nydusify
  cp ${nydusifyRawPackage}/bin/plugin $out/bin/nydusify-plugin
''
