{ ... }:
{
  programs.fish = {
    # enable = true;
    generateCompletions = true;
    interactiveShellInit = ''
      # Disable the greeting message.
      set fish_greeting
    '';
  };
}
