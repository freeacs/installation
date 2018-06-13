#!/usr/bin/env bash

function install_dependencies_init() {
  task_setup "install_dependencies" "Dependencies" "Install dependencies"
}

function install_dependencies_run() {
  apt-get -y install unzip zip curl jq libpwquality-tools mysql-server-5.7 openjdk-8-jre-headless
  if [[ $? > 0 ]]; then
    return ${E_FAILURE}
  fi
  return ${E_SUCCESS}
}
