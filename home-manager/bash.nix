{ ... }:
{
  programs.bash = {
    enable = true;
  };

  # ~/.inputrc
  programs.readline = {
    enable = true;
    bindings = {
      "\\C-h" = "backward-kill-word";
    };
    variables = {
      bell-style = "none";
      bind-tty-special-chars = true;
      blink-matching-paren = true;
      colored-completion-prefix = true;
      colored-stats = true;
      # completion-display-width = 0;
      completion-ignore-case = true;
      enable-bracketed-paste = true;
      match-hidden-files = true;
      show-all-if-ambiguous = true;
      mark-symlinked-directories = true;
    };
  };
}
