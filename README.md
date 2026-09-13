Dotfiles
========

My personal dotfiles collection.

- `.bashrc.d/01-prompt.sh` &mdash; bash prompt and window title lines. Files
  from directory `.bashrc.d/` are supposed to be sourced from `.bashrc` in a
  for-loop like

  ```sh
  for rc in "$HOME"/.bashrc.d/*.sh; do
      . "$rc"
  done
  ```

  The prompt uses the Powerline arrows and requires installation of
  [Nerd fonts](https://github.com/ryanoasis/nerd-fonts).

- `.bashrc.d/04-kitty.sh` &mdash; integration of kitty with bash.

- `.bashrc.d/06-vim.sh` &mdash; aliases `vim=nvim`, `vimdiff`, and `svim` (nvim
  wrapped in sudo).

- `.bashrc.d/08-hl.sh` &mdash; alias `hlg=hlgrep`, function `hlf` (find files
  and highlight the search patterns with [hl](https://github.com/lyokha/hl),
  requires [fd-find](https://github.com/sharkdp/fd)).

- `.config/fourmolu.yaml` &mdash; configuration for
  [fourmolu](https://github.com/fourmolu/fourmolu), a Haskell source code
  formatter.

- `.config/kitty/kitty.conf` &mdash; configuration for
  [kitty](https://github.com/kovidgoyal/kitty) which includes custom fonts and
  tab titles.

- `.config/nvim/` &mdash; configuration files for Neovim.

- `.dir_colors` &mdash; configuration for dircolors and colored ls.

- `.ghci` &mdash; configuration for GHCi, the GHC REPL.

- `.haskeline` &mdash; configuration for
  [haskeline](https://github.com/judah/haskeline), the Haskell variant of
  readline which is used in GHCi.

- `.inputrc` &mdash; configuration for readline.

- `.local/bin/` &mdash; miscellaneous scripts.

- `.vimrc.pandoc` &mdash; Vim/Neovim configuration for using with Pandoc filter
  [vimhl](https://github.com/lyokha/vim-publish-helper).

