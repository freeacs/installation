#!/usr/bin/env bash

function check_system_init() {
  task_setup "check_system" "Systemcheck" "Check system compability"
}

function check_system_run() {
  local osVer=$(get_os_version)
  if [ "$osVer" == "Ubuntu 16.04" ]; then
    return ${E_SUCCESS}
  else
    log_warning "Unknown system: $osVer"
    return ${E_FAILURE}
  fi
}

function get_os_version() {
  local os
  local ver
  if [ -f /etc/os-release ]; then
      # freedesktop.org and systemd
      . /etc/os-release
      os=$NAME
      ver=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then
      # linuxbase.org
      os=$(lsb_release -si)
      ver=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
      # For some versions of Debian/Ubuntu without lsb_release command
      . /etc/lsb-release
      os=$DISTRIB_ID
      ver=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then
      # Older Debian/Ubuntu/etc.
      os=Debian
      ver=$(cat /etc/debian_version)
  else
      # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
      os=$(uname -s)
      ver=$(uname -r)
  fi
  echo "$os $ver"
}