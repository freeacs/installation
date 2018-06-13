#!/usr/bin/env bash

function check_mysql_version_init() {
  task_setup "check_mysql_version" "MySQLVersion" "Check MySQL version"
}

function check_mysql_version_run() {
  local mysqlok=$(mysql --version | grep 5.7 | wc -l)
  if [ $mysqlok != '1' ] ; then
    log_warning "
    The command 'mysql --version' doesn't seem to return the expected '5.7' string.
    One explanation is that you've installed the wrong version of MySQL. Please
    correct this before you continue
    "
	  return ${E_FAILURE}
  fi
  log_info "Found mysql version: $mysqlok"
  return ${E_SUCCESS}
}