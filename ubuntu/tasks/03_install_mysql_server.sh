#!/usr/bin/env bash

function install_mysql_server_init() {
   task_setup "install_mysql_server" "MySQLInstall" "Install MySQL"
}

function install_mysql_server_run() {
  local rootPass
  if type mysql >/dev/null 2>&1; then
    rootPass=$(pwmake 128)
    apt-get -y remove --purge 'mysql*'
    echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
    echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
    apt-get -y install mysql-server-5.7
    echo -e "root\nn\nY\nY\nY\nY\n" | mysql_secure_installation
    mysql -u root --password="$rootPass" -e <<-EOSQL
      DELETE FROM mysql.user WHERE User='';
      DROP DATABASE IF EXISTS test;
      DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
      DELETE FROM mysql.user where user != 'mysql.sys';
      CREATE USER 'root'@'%' IDENTIFIED BY '${rootPass}';
      GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
EOSQL
    systemctl restart mysql
  else
    rootPass=$(enter_variable_hidden "Enter mysql root password")
  fi
  settings_set "mysql_root_password" ${rootPass}
}