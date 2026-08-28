{
  pkgs,
  ...
}:
let
  erlang = pkgs.beam27Packages.erlang;
  elixir = pkgs.beam27Packages.elixir_1_19;
  #elixir = pkgs.beam.packages.erlang.elixir;
  #elixir-ls = pkgs.beam.packages.erlang.elixir_ls;
  #elixir-wrapper = pkgs.symlinkJoin {
  #  name = "elixir-wrapper";
  #  paths = [ elixir ];
  #  postBuild = ''
  #    # The plugin wants /lib/iex, etc.
  #    # Nix has them at /lib/elixir/lib/iex
  #    # We create symlinks at the top level of the /lib folder
  #    ln -s ${elixir}/lib/elixir/lib/* $out/lib/
  #  '';
  #};
in
{
  environment.systemPackages = with pkgs;
  [
    erlang
    elixir
    #elixir-wrapper
    gleam
    dexter # Elixir LSP.
  ];

  environment.variables =
  {
    "ERL_TOP" = "${erlang}/lib/erlang";
    #"ERLANG_SDK_HOME" = "${erlang}";
    #"ELIXIR_SDK_HOME" = "${elixir}";
    #"ELIXIR_SDK_HOME" = "${elixir-wrapper}";
    "ERLANG_SDK_HOME" = "${erlang}/lib/erlang";
    "ELIXIR_SDK_HOME" = "${elixir}/lib/elixir";
    "GLEAM_SDK_HOME" = "${elixir}/lib/elixir";
  };
}
