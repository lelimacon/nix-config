{
  pkgs,
  ...
}:
let
  erlang = pkgs.beam27Packages.erlang;
  elixir = pkgs.beam27Packages.elixir_1_17;
in
pkgs.mkShell
{
  description = "Elixir & Gleam.";

  buildInputs = with pkgs;
  [
    #bashInteractive
    erlang
    elixir
    gleam

    #asdf-vm # runtime version manager.
    #mise # runtime version manager.
    go-task # task runner.
    caddy # HTTP web server.
    nodejs_20

    fop # XML driver.
    openssl
    unixODBC
    javaPackages.compiler.openjdk25
    poppler # PDF rendering library.

    openssh # ssh client for git dependencies
    go-task # task runner
    awscli2 # AWS utility
    #lexical # Elixir language server. [DEPRECATED]
    elixir-ls # Elixir language server.
    #next-ls # Elixir language server. [DEPRECATED]
    # https://github.com/elixir-lang/expert
    # https://expert-lsp.org/docs/installation/
    #k9s
    #kubecolor
    #kubectl
    lsof
    #gh # GitHub CLI
    ncurses
  ];

  shellHook =
  ''
    #export LANG=en_US.UTF-8
    #export LC_ALL=en_US.UTF-8

    #source ${pkgs.asdf-vm}/etc/profile.d/asdf-prepare.sh
    #. "$HOME/.asdf/asdf.sh"
    #. "$HOME/.asdf/completions/asdf.bash"

    export ERL_TOP="${erlang}/lib/erlang"
    export ERLANG_SDK_HOME="${erlang}/lib/erlang"
    export ELIXIR_SDK_HOME="${elixir}/lib/elixir"
    export GLEAM_SDK_HOME="${pkgs.gleam}/lib"

    export ERLANG_VERSION="$(erl -noshell -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().')"
    export ELIXIR_VERSION="$(elixir --eval 'IO.puts(System.version)')"
    export GLEAM_VERSION="$(gleam --version | awk '{print $2}')"

    echo "Erlang  $ERLANG_VERSION"
    echo "Elixir  $ELIXIR_VERSION"
    echo "Gleam   $GLEAM_VERSION"
  '';
}
