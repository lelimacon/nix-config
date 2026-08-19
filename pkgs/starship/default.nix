# Starship prompt wrapper.
# https://starship.rs
{
  pkgs,
  wrappers,
  ...
}:
wrappers.wrappers.starship.wrap
{
  inherit pkgs;

  settings =
  {
    add_newline = false;
    format = "$shlvl$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
    shlvl =
    {
      disabled = false;
      symbol = "↑";
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
      symbol = "";
      format = "[$symbol$name]($style) ";
      style = "bright-purple bold";
    };
    git_branch =
    {
      only_attached = true;
      format = "[$symbol](yellow)[$branch]($style)";
      symbol = " ";
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
      format = "\\([$state($progress_current/$progress_total)]($style)\\)";
      style = "bright-orange bold";
    };
    git_status =
    {
      format = "[:](yellow)[$all_status$ahead_behind]($style) ";
      style = "bright-yellow bold";
    };
    directory =
    {
      read_only = " ";
      truncation_length = 0;
    };
    cmd_duration =
    {
      min_time = 1000;
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
}
