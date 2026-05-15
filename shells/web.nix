{
  pkgs,
  ...
}:
let
  node = pkgs.nodejs_20;
in
pkgs.mkShell
{
  description = "Node 20.";

  buildInputs = with pkgs;
  [
    caddy # HTTP web server.
    node
  ];

  shellHook =
  ''
    export NODE_SDK_HOME="${node}"

    export NODE_VERSION="$(npm version --json | jq --raw-output '.node')"
    export NPM_VERSION="$(npm --version)"

    echo "Node    $NODE_VERSION"
    echo "NPM     $NPM_VERSION"
  '';
}
