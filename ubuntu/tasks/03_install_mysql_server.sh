#!/usr/bin/env bash

function install_mysql_server_init() {
   task_setup "install_mysql_server" "MySQLInstall" "Install MySQL"
   
   settings_init ".settings"
}

function install_mysql_server_run() {
  settings_set "mysql_root_password" $(pwmake 128)
}