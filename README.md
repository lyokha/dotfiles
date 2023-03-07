Dotfiles
========

My personal dotfiles collection.

- `.bashrc.d/prompt.sh` --- bash prompt and window title lines. Files from
  directory `.bashrc.d/` are supposed to be sourced from `.bashrc` in a
  for-loop like

  ```sh
  for rc in "$HOME"/.bashrc.d/*.sh; do
      . "$rc"
  done
  ```

  The prompt uses the powerline arrows and requires installation of
  [Nerd fonts](https://github.com/ryanoasis/nerd-fonts).

- `.config/kitty/kitty.conf` --- configuration for
  [kitty](https://github.com/kovidgoyal/kitty) which includes custom fonts and
  tab titles.

- `.config/nvim/` --- configuration files for Neovim.

- `.vimrc.pandoc` --- Vim/Neovim configuration for using with Pandoc filter
  [vimhl](https://github.com/lyokha/vim-publish-helper).

