{
  inputs,
  pkgs,
  ...
}:
let
  aliases =
  {
    ".." = "cd ..";
    "..." = "cd ../..";

    "l" = "eza";
    "ll" = "eza -l --icons";
    "tree" = "eza --tree";

    "code" = "codium";
  };
in
{
  # Bash.
  programs.bash =
  {
    enable = true;

    shellAliases = aliases;
    initExtra =
    ''
      SHELL=${pkgs.bash}
    '';
  };

  # Kitty.
  programs.kitty =
  {
    enable = true;

    settings =
    {
      confirm_os_window_close = 0;

      enable_audio_bell = true;

      mouse_hide_wait = "-1.0"; # hide cursor immediately when typing.

      window_padding_width = 2;

      dynamic_background_opacity = true;
      background_opacity = "1";
      background_blur = 0;

      font_size = 12;
      font_family = "Fira Code";
    };
  };

  # Starship.
  # https://starship.rs/config
  programs.starship =
  {
    enable = true;

    enableBashIntegration = true;
    settings =
    {
      add_newline = false;
      format = "$shlvl$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
      shlvl =
      {
        disabled = false;
        symbol = "↕️ ";
        style = "bright-red bold";
      };
      username =
      {
        style_user = "bright-white bold";
        style_root = "bright-red bold";
      };
      hostname =
      {
        ssh_only = true;
        style = "bright-green bold";
      };
      nix_shell =
      {
        symbol = "";
        format = "[$symbol$name]($style) ";
        style = "bright-purple bold";
      };
      git_branch =
      {
        only_attached = true;
        format = "[$symbol](yellow)[$branch]($style)";
        symbol = " ";
        style = "bright-yellow bold";
      };
      git_commit =
      {
        only_detached = true;
        format = "[:](yellow)[$hash]($style)";
        style = "bright-yellow bold";
      };
      git_state =
      {
        format = "\([$state($progress_current/$progress_total)]($style)\)";
        style = "bright-orange bold";
      };
      git_status =
      {
        format = "[:](yellow)[$all_status$ahead_behind]($style) ";
        style = "bright-yellow bold";
      };
      directory =
      {
        read_only = " ";
        truncation_length = 0;
      };
      cmd_duration =
      {
        min_time = 1000; # ms to show.
        format = "[$duration]($style) ";
        style = "bright-blue";
      };
      jobs =
      {
        style = "bright-green bold";
      };
      character =
      {
        success_symbol = "[\\$](bright-green bold)";
        error_symbol = "[\\$](bright-red bold)";
      };
    };
  };
}
