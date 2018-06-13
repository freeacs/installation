#!/usr/bin/env bash

function download_release_init() {
  task_setup "download_release" "Download" "Download release files"
}

function download_release_run() {
  rm -rf files.txt
  rm -rf *.deb
  rm -rf *.pdf
  local whattodownload="deb|tables|pdf"
  curl -s https://api.github.com/repos/freeacs/freeacs/releases/latest | jq -r ".assets[] | select(.name | test(\"${whattodownload}\")) | .browser_download_url" > files.txt
  awk '{print $0;}' files.txt | xargs -l1 curl -OL
  unzip -o "*.zip"
  rm -rf *.zip
}