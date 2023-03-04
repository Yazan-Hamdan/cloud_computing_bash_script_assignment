#!/bin/bash

# Define variables
user=$(whoami)
date=$(date)
os=$(uname -a)

# Define functions
function show_menu() {
  echo "Welcome $user!"
  echo "Today is $date"
  echo "You are using $os"
  echo "Please select an option:"
  echo "1. List the running process"
  echo "2. Check the memory status and free memory in the RAM"
  echo "3. Check the hard disk status and free memory in the HDD"
  echo "4. Check if Apache is installed and if yes return its version"
  echo "5. Exit"
}

function process_menu_choice() {
  case $1 in
    1) show_running_process ;;
    2) check_memory_status ;;
    3) check_hard_disk_status ;;
    4) check_apache_version ;;
    5) exit 0 ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
}

function show_running_process() {
  echo "Running processes:"
  ps -ef
  show_options
}

function check_memory_status() {
  echo "Memory status:"
  free -m
  show_options
}

function check_hard_disk_status() {
  echo "Hard disk status:"
  df -h
  show_options
}

function check_apache_version() {
  if [[ $(which apache2) ]]; then
    echo "Apache version:"
    apache2 -v
  else
    echo "Apache is not installed."
  fi
  show_options
}

function show_options() {
  echo "Please select an option:"
  echo "1. Back to main menu"
  echo "2. Update view"
  echo "3. Exit"
  read -p "Enter option number: " choice
  process_options_choice $choice
}

function process_options_choice() {
  case $1 in
    1) show_menu ;;
    2) clear ; show_menu ; show_options ;;
    3) exit 0 ;;
    *) echo "Invalid choice. Please try again." ; show_options ;;
  esac
}

# Main function
function main() {
  if [ $# -eq 0 ]; then
    while true; do
      show_menu
      read -p "Enter option number: " choice
      process_menu_choice $choice
    done
  else
    for arg in "$@"; do
      case $arg in
        p) show_running_process ;;
        r) check_memory_status ;;
        h) check_hard_disk_status ;;
        a) check_apache_version ;;
        *) echo "Invalid argument. Please try again." ; exit 1 ;;
      esac
    done
  fi
}

# Call main function
main "$@"