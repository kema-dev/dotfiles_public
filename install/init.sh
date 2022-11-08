#!/bin/bash

function declare_colors_and_set_error() {
	INFO='\033[0;34m'
	ERROR='\033[0;31m'
	WARNING='\033[0;33m'
	SUCCESS='\033[0;32m'
	NOCOLOR='\033[0m'
	set -e
}

function request_sudo() {
	echo -e "${INFO}Requesting sudo permissions...${NOCOLOR}"
	sudo echo -e "${SUCCESS}Permissions for sudo granted successfully${NOCOLOR}"
}

function update_system() {
	echo -e "${INFO}Updating system...${NOCOLOR}"
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y
	echo -e "${SUCCESS}System updated successfully${NOCOLOR}"
}

function check_for_reboot() {
	echo -e "${INFO}Checking for reboot...${NOCOLOR}"
	if [ -f /var/run/reboot-required ]; then
		echo -e "${WARNING}Reboot required${NOCOLOR}"
		echo -e "${WARNING}Please reboot your machine${NOCOLOR}"
		exit 2
	else
		echo -e "${SUCCESS}No reboot required${NOCOLOR}"
	fi
}

function install_ansible {
	echo -e "${INFO}Installing ansible...${NOCOLOR}"
	sudo apt install -y ansible-core
	echo -e "${SUCCESS}Ansible installed successfully${NOCOLOR}"
}

function install_github_cli_and_log() {
	echo -e "${INFO}Installing GitHub CLI...${NOCOLOR}"
	sudo apt install -y gh
	echo -e "${INFO}Logging in to GitHub CLI...${NOCOLOR}"
	if gh auth status
	then
			echo -e "${INFO}Already logged in to GitHub CLI${NOCOLOR}"
	else
			echo -e "${INFO}Not logged in to GitHub CLI, please log in${NOCOLOR}"
			gh auth login
	fi
	echo -e "${SUCCESS}GitHub CLI installed and logged in successfully${NOCOLOR}"
}

function get_repo_and_update() {
	echo -e "${INFO}Getting the latest version of the repo...${NOCOLOR}"
	if [ -d ~/.dotfiles ]; then
		echo -e "${INFO}~/.dotfiles already exists${NOCOLOR}"
		cd ~/.dotfiles
		if [ ! $(git remote get-url origin | grep "https://github.com/kema-dev/dotfiles_public") ]; then
			echo -e "${ERROR}~/.dotfiles remote origin is not kema-dev/dotfiles_public, please remove ~/.dotfiles and try again${NOCOLOR}"
			exit 1
		fi
		echo -e "${INFO}~/.dotfiles remote origin is ok, pulling...${NOCOLOR}"
		gh repo sync
	else
		echo -e "${INFO}~/.dotfiles does not exist${NOCOLOR}"
		echo -e "${INFO}Cloning repo to ~/.dotfiles...${NOCOLOR}"
		gh repo clone https://github.com/kema-dev/dotfiles_public ~/.dotfiles
		cd ~/.dotfiles
		echo -e "${INFO}Repo cloned successfully${NOCOLOR}"
	fi
	echo -e "${SUCCESS}Repo updated successfully${NOCOLOR}"
}

function run_playbook() {
	echo -e "${INFO}Executing playbook to setup development environment...${NOCOLOR}"
	echo -e "${WARNING}You will be prompted for your sudo password (BECOME password)${NOCOLOR}"
	cd ~/.dotfiles/ansible
	ansible-playbook main.yml
	echo -e "${SUCCESS}Playbook executed successfully${NOCOLOR}"
}
function print_success_message() {
	echo -e "${SUCCESS}Full setup completed successfully${NOCOLOR}"
	echo -e "${WARNING}You still need to setup manually: Dual Boot, Display settings, Wallpapers, Default terminal, Default web browser, Desktop panel profile, VPN, SSH keys, Web browsers, VSCode${NOCOLOR}"
	echo -e "${WARNING}You might need to source your shell to apply some changes, and even re-log for some others (e.g. Docker)${NOCOLOR}"
	echo -e "${WARNING}A complete reboot is recommended${NOCOLOR}"
}

function main() {
	declare_colors_and_set_error
	request_sudo
	update_system
	check_for_reboot
	install_ansible
	install_github_cli_and_log
	get_repo_and_update
	run_playbook
	print_success_message
}

main
