{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Inference engines.
    llama-cpp # inference engine supporting GGUF.
    ollama # llama.cpp wrapper.
    #stable-diffusion-cpp # image/video inference engine.

    # Coding agents.
    qwen-code
    goose-cli
    inputs.paseo.packages.${pkgs.system}.desktop # self-hosted daemon for Claude Code/Codex/OpenCode (desktop app).

    # Libraries.
    uv # Python package manager.
    (python3.withPackages (ps:
    [
      ps.safetensors
      ps.numpy
    ]))

    # Other tools.
    #rembg # tool to remove background from images.
  ];
}
