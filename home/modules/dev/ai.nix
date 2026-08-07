{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    llama-cpp # inference engine supporting GGUF.
    ollama # llama.cpp wrapper.
    stable-diffusion-cpp
    #rembg # tool to remove background from images.
    git-xet # Git LFS plugin for Xet protocol.

    uv # Python package manager.
    (python3.withPackages (ps:
    [
      ps.safetensors
      ps.numpy
    ]))
  ];
}
