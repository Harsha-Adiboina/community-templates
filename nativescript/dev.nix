# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, lib, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_20
    pkgs.jdk17
    # To use Firebase features, add pkgs.google-cloud-sdk here and uncomment the
    # npm install line in the onCreate block below.
    pkgs.google-cloud-sdk
  ];
  # Sets environment variables in the workspace
  env = { };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "nrwl.angular-console"
      "esbenp.prettier-vscode"
      "firsttris.vscode-jest-runner"
    ];

    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        install = ''
          npm ci --prefer-offline --no-audit --no-progress --timing
          # To use Firebase Analytics, uncomment the following line:
          npm install --save @nativescript/firebase-analytics
        '';
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "app/app.js" ];
      };
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      # previews = {
        # web = {
        #   command = [ "npx" "ns" "preview" "--port" "$PORT" "--host" "0.0.0.0" ];
        #   manager = "web";
        # };
      # };
    };
  };
}
