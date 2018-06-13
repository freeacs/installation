#!/usr/bin/env bash

function upgrade_system_init() {
  task_setup "upgrade_system" "Upgrade" "Upgrade system"
}

function upgrade_system_run() {
  apt-get -y update && apt-get -y upgrade
  if [[ $? > 0 ]]; then
    return ${E_FAILURE}
  fi
  return ${E_SUCCESS}
}