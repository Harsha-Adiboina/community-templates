/*
 Copyright 2024 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

{ pkgs, template ? "js", ts ? false, ... }: {
 channel = "stable-25.05";
packages = [
    pkgs.nodejs
    pkgs.python3
    pkgs.python311Packages.pip
    pkgs.python311Packages.fastapi
    pkgs.python311Packages.uvicorn
  ];
 bootstrap = ''
   mkdir -p "$WS_NAME"
       if [ "${template}" = "vue" ]; then
     npx nativescript create "$WS_NAME" --template @nativescript-vue/template-blank@latest
   else
     npx nativescript create "$WS_NAME" --${template} ${if ts then "--ts" else ""}
   fi
     mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
 
    chmod -R u+w "$out"
    cd "$out"; npm install -D nativescript
    cd "$out"; npm install --package-lock-only --ignore-scripts
 
 '';
}
