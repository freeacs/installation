#!/usr/bin/env bash

function install_mysql_server_init() {
  task_setup "install_mysql_server" "MySQLInstall" "Install MySQL"
  settings_init ".settings"
}

function install_mysql_server_run() {
  local rootPass
  if type mysql >/dev/null 2>&1; then
    rootPass=$(enter_variable_hidden "Enter mysql root password")
  else
    rootPass=$(pwmake 128)
    echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
    echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
    apt-get -y install mysql-server-5.7 && mysqladmin -u root --password="root" password $rootPass
    if [[ $? > 0 ]]; then
      return ${E_FAILURE}
    fi
  fi
  settings_set "mysql_root_password" ${rootPass}
  return ${E_SUCCESS}
}