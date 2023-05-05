# zshrc

```markdown
      ___           ___           ___           ___           ___     
     /  /\         /  /\         /__/\         /  /\         /  /\    
    /  /::|       /  /:/_        \  \:\       /  /::\       /  /:/    
   /  /:/:|      /  /:/ /\        \__\:\     /  /:/\:\     /  /:/     
  /  /:/|:|__   /  /:/ /::\   ___ /  /::\   /  /:/~/:/    /  /:/  ___ 
 /__/:/ |:| /\ /__/:/ /:/\:\ /__/\  /:/\:\ /__/:/ /:/___ /__/:/  /  /\
 \__\/  |:|/:/ \  \:\/:/~/:/ \  \:\/:/__\/ \  \:\/:::::/ \  \:\ /  /:/
     |  |:/:/   \  \::/ /:/   \  \::/       \  \::/~~~~   \  \:\  /:/ 
     |  |::/     \__\/ /:/     \  \:\        \  \:\        \  \:\/:/  
     |  |:/        /__/:/       \  \:\        \  \:\        \  \::/   
     |__|/         \__\/         \__\/         \__\/         \__\/    
```

My personal `.zshrc`, which I use on my home and work systems.

## Installation

- From within the cloned repo, run the script: `bash ./link_zshrc.sh`

## My tweaks

1. Disables compfix for Oh My Zsh to avoid issues with insecure directories.
2. Sets up syntax highlighting and history substring search.
3. Configures bracketed paste magic for faster pasting with autosuggestions.
4. Sets up locale settings.
5. Configures the `PATH` variable for various tools and utilities.
6. Configures Git aliases and sets up Visual Studio Code as the default Git editor.
7. Sets up aliases for various commands, like Terraform, Neovim, and more.
8. Configures Node Version Manager (NVM) and autoloads the appropriate Node.js version based on `.nvmrc` files.
9. Sets up PATH for various tools, like Yarn, Rancher Desktop, and RVM.
11. Sets up the prompt with Starship and runs some commands upon startup, like `fastfetch`.
