{...}: {
  programs.bash.enable = true;
  programs.bash.historyControl = [
    "erasedups"
    "ignoredups"
    "ignorespace"
  ];
  programs.bash.historyFileSize = 100000;
  programs.bash.historySize = 10000;
  programs.bash.initExtra = ''
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/adalon-github
  '';
  programs.bash.shellAliases = {
    lse = "ls -Fho";
    lsa = "lse -A";
    lock = ''
      swaylock \
      --screenshots \
      --clock \
      --indicator-radius 100 \
      --indicator-thickness 7 \
      --effect-blur 7x5 \
      --effect-vignette 0.5:0.5 \
      --ring-color bb00cc \
      --key-hl-color 880033 \
      --line-color 00000000 \
      --inside-color 00000088 \
      --separator-color 00000000 \
      --grace 2 \
      --fade-in 0.2
    '';
  };
  programs.bash.shellOptions = [
    # Append to history file rather than replacing it.
    "histappend"

    # Check the window size after each command and, if necessary, update the
    # values of LINES and COLUMNS.
    "checkwinsize"

    # Extended globbing.
    "extglob"
    "globstar"

    # Warn if closing shell with running jobs.
    "checkjobs"

    # Do not fix cd commands or cd into a directory if a command was given that
    # matches a directory name.
    "-autocd"
    "-cdspell"
  ];
}
