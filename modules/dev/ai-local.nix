{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Inference engines.
    llama-cpp # inference engine supporting GGUF.
    ollama # llama.cpp wrapper.
    #stable-diffusion-cpp # image/video inference engine.
    openai-whisper # speach-to-text.

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

  # Configuration for coding agents.
  environment.sessionVariables =
  {
    "OPENAI_API_KEY" = "local"; # any non-empty string.
    "OPENAI_BASE_URL" = "http://localhost:11434/v1"; # llama.
    "OPENAI_MODEL" = "qwen3-coder:30b";
  };

  # Qwen configuration.
  /*
  home.file.".qwen/settings.json".text =
  ''
    {
      "ide": {
        "hasSeenNudge": true
      },
      "$version": 2,
      "security": {
      "auth": {
        "selectedType": "openai",
        "apiKey": "local",
        "baseUrl": "http://localhost:11434/v1"
        }
      },
      "model": {
        "name": "qwen3-coder:30b"
      },
      "ui": {
        "accessibility": {
          "enableLoadingPhrases": false
        }
      }
    }
  '';
  */
}
