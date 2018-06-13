#!/usr/bin/env bash

function check_java_version_init() {
  task_setup "check_java_version" "JavaVersion" "Check Java major version"
}

function check_java_version_run() {
  local majorVersion=$(java -version 2>&1 | head -n 1 | awk -F'["_.]' '{print $3}')
  if [ ${majorVersion} -eq "8" ]; then
    log_info "Found Java major version: $majorVersion"
    return ${E_SUCCESS}
  fi
  log_warning "Found unsupported Java major version $majorVersion"
  return ${E_FAILURE}
}