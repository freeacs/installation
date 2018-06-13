# User configuration.
#
# This file should contain the product-specific configuration.
# For example, one may overwrite default global configuration
# values such as ROOT_ONLY.
# Plus, one should define the three greeter functions 'welcome',
# 'installation_complete', and 'installation_incomplete'.

# Set to 1 to enforce root installations.
#ROOT_ONLY=0

# Overwrite to disable the initial touch-all-files.
#INITIAL_TOUCH_ALL=1

# Overwrite to disable task dependency checking.
#TASK_DEPENDENCY_CHECKING=1

# Overwrite default utils & tasks directories.
#UTILS_DIR=${INSTALLER_PATH}/data/utils
#TASKS_DIR=${INSTALLER_PATH}/data/tasks

# Overwrite default log-to-stdout config.
#LOG_STDOUT=( "ERROR" "IMPORTANT" "WARNING" "INFO" "SKIP" "START" "FINISH" )

function welcome() {
  echo -e "\e[00;32mFreeACS Installation\e[00m"
}

function installation_complete() {
  echo -e "\e[00;32mInstallation is complete!\e[00m"
  exit 0
}

function installation_incomplete() {
  echo -e "\e[00;31mInstallation completed with errors!\e[00m"
}