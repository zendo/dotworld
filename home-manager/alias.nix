{
  lib,
  pkgs,
  config,
  ...
}:
{
  home.shellAliases = {
    cat = "${lib.getExe pkgs.bat} -p";
    l = "${lib.getExe pkgs.eza} -l --icons";
    "la." = "ls -d .*";
    rm = "${lib.getExe pkgs.gtrash} put";
    rm-empty = "${lib.getExe pkgs.gtrash} find --rm";
    rm-restore = "${lib.getExe pkgs.gtrash} restore";
    free = "free -h";
    bc = "${lib.getExe pkgs.libqalculate}";
    inxi = "inxi -Fz";
    ip = "ip --color=auto";
    ip-info = "curl ip.im/info";
    nload = "${lib.getExe pkgs.nload} devices wlp1s0";
    psp = "${lib.getExe pkgs.procs} --sortd UsageMem";
    ps-sort = ''ps -ewwo pid,%cpu,%mem,nice,pri,rtprio,args --sort=-pcpu,-pid | awk -v filter="$1" 'NR==1 || tolower($0) ~ tolower(filter)' | less -e --header=1'';
    dd-log = "sudo dd bs=8M oflag=sync,direct conv=fsync status=progress";
    mount-ls = "mount | column -t";
    beep = ''echo -en "\007"'';
    journalctl-1h = ''journalctl -p err..alert --since "60 min ago"'';

    paste-termbin = "nc termbin.com 9999";
    paste-rs = "curl --data-binary @- https://paste.rs/";

    nse = "nix search nixpkgs";
    j = "just --justfile=${config.home.homeDirectory}/nsworld/justfile";
    e = "emacs -nw";
    ee = "emacsclient --create-frame";
    ee-config = "emacs --init-directory ~/.config/emacs";
    ssr = "export {http,https,ftp}_proxy=socks5h://127.0.0.1:7897 ;export {HTTP,HTTPS,FTP}_PROXY=socks5h://127.0.0.1:7897";
    nix-build-package = ''nix build --impure --expr "(import <nixpkgs> {}).callPackage ./package.nix {}" -L'';
    nix-build-pr = ''f() { nix build github:NixOS/nixpkgs/pull/$1/merge#$2 }; f'';
  };
}
