# dotfiles

My custom apps, tools, config files and settings for a joyful development experience, set up automatically with ansible!

## Disclaimer

***This is a work in progress. I'm not responsible for any damage caused by using these files. Moreoever, this script is intended to be run on a fresh install of [Kali Linux](https://www.kali.org/) rolling release. It may not work on other distros, and it may break on a system that has already been configured. I plan to work on this in the future to make it more robust.***

## Why is this repo mentionned "_pub" ?

To prevent from leaking personal information I've removed some parts of the setup, most importantly the original `dotfiles/` folder and thus commented out `dotfiles_custom` ansible task in `ansible/main.yml`. You can still use this repository as a template to create your own dotfiles, but you will have to set up your own settings for dotfiles defined in `ansible/roles/dotfiles_custom/vars/main.yml` and enable `dotfiles_custom` ansible task in `ansible/main.yml`. This includes `~/.zshrc`, thus you need to modify it to enable some features (like zsh plugins installed in `ansible/roles/dotfiles`). Do not hesitate to email me at `git@kemadev.fr` if you want to get a preview of those custom dotfiles!

Moreover, this repository being a public version, its current state does not reflect the current state of development.

## Why is GitHub CLI used in init script?

I chose to use GitHub CLI instead of git to clone this repository because its easing the login process. It allows to clone private repositories without having to set up SSH keys.

## Customization

- All ansible roles work in a similar fashion. They are defined in `ansible/roles/` and are called in `ansible/main.yml`, which is a wrapper.
- Each role has a `ansible/roles/<role>/vars/main.yml` file that contains objects with specific attributes. In most of them, a `method` attribute is used to define the installation method, and the attribute itself has a `name` attribute that is used to pick the right installation method as follows : `ansible/roles/<role>/tasks/methods/<method_name>.yml`. `method`'s attribute has other attributes that are used by the installation method, and each object in `ansible/roles/<role>/vars/main.yml` has other attributes that are used by the role.
- You can add new methods for new objects just by adding new files `ansible/roles/<role>/tasks/methods/<method_name>.yml` and adding the corresponding objects in `ansible/roles/<role>/vars/main.yml` file.
- You can add objects in `ansible/roles/<role>/vars/main.yml` to install more apps, tools, etc. You can also add new attributes to existing objects to customize the installation process by modifying the corresponding installation method(s).

## Installation

Just run `install/init.sh`. Below is a one-liner to do this:

```bash
bash -c "$(curl -fsSL https://raw.github.com/kema-dev/dotfiles_public/main/install/init.sh)"
```

## What is set up ?

- [Kali Linux](https://www.kali.org/) is updated and upgraded
- [Ansible](https://www.ansible.com/) is installed
- [GitHub CLI](https://cli.github.com/) is installed
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) and [JetBrainsMonoNF](https://github.com/ryanoasis/nerd-fonts) fonts are installed
- Some useful tools are installed using debian packages:
  - [brave](https://brave.com/) - Web browser
  - [discord](https://discord.com/) - Chat app
  - [spotify](https://www.spotify.com/) - Music app
  - [vscode](https://code.visualstudio.com/) - Code editor
  - [virtualbox](https://www.virtualbox.org/) - Virtualization software
  - [docker](https://www.docker.com/) - Containerization software
  - [delta](https://github.com/dandavison/delta) - Git diff viewer
  - [rust](https://www.rust-lang.org/) - Programming language
  - [chrome](https://www.google.fr/chrome) - Web browser
  - [firefox_stable](https://www.mozilla.org/en-US/firefox/) - Web browser
  - [firefox_dev](https://www.mozilla.org/en-US/firefox/developer/) - Web browser, with dev tools
- Some useful tools are installed using apt:
  - [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
  - [thefuck](https://github.com/nvbn/thefuck) - Mispelled commands correcter
  - [exa](https://github.com/ogham/exa) - Modern ls implementation
  - [bat](https://github.com/sharkdp/bat) - Modern cat implementation
  - [neovim](https://neovim.io/) - Vim fork
  - [autokey-gtk](https://manpages.org/autokey-gtk) - Keyboard macro manager
  - [tmux](https://github.com/tmux/tmux) - Terminal multiplexer
  - [fd-find](https://github.com/sharkdp/fd) - Modern find implementation
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - Command-line search tool
  - [xfce4-panel-profiles](https://docs.xfce.org/apps/xfce4-panel-profiles/start) - Xfce panel profiles manager
  - [golang-go](https://go.dev/) - Programming language
  - [nodejs](https://nodejs.org/) - Programming language
  - [npm](https://www.npmjs.com/) - Package manager for nodejs
  - [ruby](https://www.ruby-lang.org/) - Programming language
  - [cmake](https://cmake.org/) - Build system
  - [python3](https://www.python.org/) - Programming language
  - [python3-pip](https://pypi.org/project/pip/) - Package manager for python3
  - [ansible-lint](https://docs.ansible.com/) - Ansible linter
  - [httpie](https://github.com/httpie/httpie) - Modern curl implementation
- Some useful tools are installed using pip:
  - [arsenal-cli](https://github.com/Orange-Cyberdefense/arsenal) - Pentesting commands easy launcher
  - [glances](https://github.com/nicolargo/glances) - System monitoring tool
  - [asciinema](https://github.com/asciinema/asciinema) - Terminal recording tool
- Some useful tools are installed using cargo:
  - [tealdeer](https://github.com/dbrgn/tealdeer) - Modern tldr implementation
  - [sd](https://github.com/chmln/sd) - Modern sed implementation
  - [alacritty](https://github.com/alacritty/alacritty) - Terminal emulator
- Some useful tools are installed using GitHub CLI:
  - [clean-branches](https://github.com/davidraviv/gh-clean-branches) - Git branches cleaner
  - [fuzzyclone](https://github.com/hashue/gh-fuzzyclone) - Fuzzy searcher for GitHub repositories
  - [dash](https://github.com/dlvhdr/gh-dash) - GitHub dashboard
- Some configuration is done (but is not present in this repository, see above):
  - Custom `gitconfig` - Git configuration
  - Custom `tmux` - Terminal multiplexer
  - Custom `alaclritty` - Terminal emulator
  - Custom `zsh plugin` - Zsh plugin
  - Custom `zsh theme` - Zsh theme
  - Custom `zshrc` - Wrapper for zsh configuration
- Some shell tools are installed:
  - [NvChad](https://github.com/NvChad/NvChad) - Neovim configuration
  - [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) - Zsh framework
  - [alias-tips](https://github.com/djui/alias-tips) - Aliases reminder
  - [forgit](https://github.com/wfxr/forgit) - Git commands improvements
  - [fzf-tab](https://github.com/Aloxaf/fzf-tab) - Fuzzy tab completion
  - [fzf-zsh-plugin](https://github.com/unixorn/fzf-zsh-plugin) - Fuzzy zsh history
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Command suggestions
  - [zsh-interactive-cd](https://github.com/changyuheng/zsh-interactive-cd) - Fuzzy cd
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Command syntax highlighter
  - [z.lua](https://github.com/skywind3000/z.lua) - Directory jump
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k) - Prompt theme
- Some miscellanous settings are set up:
  - `Timezone` is set to Europe/Paris
  - `App shortcuts` for file manager ([Thunar](https://docs.xfce.org/xfce/thunar/start)), terminal emulator ([Alacritty](https://alacritty.org/)), and clipboard history (xfce4-clipman-history)
  - `GitHub CLI` pager and editor are set to [delta](https://github.com/dandavison/delta) and [nvim](https://neovim.io/) respectively
