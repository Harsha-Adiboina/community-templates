
{ pkgs, ... }: {
  packages = [
    pkgs.go
  ];
  bootstrap = ''
    mkdir "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev/.idx/dev.nix} "$out/.idx/dev.nix"
    shopt -s dotglob; cp -r ${./dev}/* "$out"
    chmod -R +w "$out"
    cd "$out"
    go mod init pocketbase-app
    go mod tidy
  '';
}
