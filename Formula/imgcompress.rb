class Imgcompress < Formula
  desc "Compress and convert PNG, JPEG, WebP, GIF, AVIF, JPEG XL and HEIC images"
  homepage "https://nickv2002.github.io/ImageCompress/"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # One universal tarball serves both Mac architectures.
  on_macos do
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.23.1/imgcompress-2026.11.23.1-macos-universal.tar.gz"
      sha256 "8c6b80ec7e93580c0dc59ed2f2f25e53ff0a94139a6c087dd31698ea8e7e4bde"
    end
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.23.1/imgcompress-2026.11.23.1-macos-universal.tar.gz"
      sha256 "8c6b80ec7e93580c0dc59ed2f2f25e53ff0a94139a6c087dd31698ea8e7e4bde"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.23.1/imgcompress-2026.11.23.1-linux-x86_64.tar.gz"
      sha256 "f9b9186e0703cfae235708b5689fa43d5185c202de8c5baba8ba72a44dd720e2"
    end
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.23.1/imgcompress-2026.11.23.1-linux-aarch64.tar.gz"
      sha256 "e6cd5d336c4d98dcab837da2b03f0bd4adf2f2c460f9428d6d5e5ca7c512413a"
    end
  end

  def install
    # gifsicle stays private to imgcompress (in libexec) so it never clashes with Homebrew's gifsicle;
    # imgcompress resolves its bin/ link and finds it there.
    libexec.install "imgcompress", "gifsicle"
    (libexec/"licenses").install Dir["licenses/*"] if File.directory?("licenses")
    bin.install_symlink libexec/"imgcompress"
    generate_completions_from_executable(bin/"imgcompress", "completions")
    (man1/"imgcompress.1").write Utils.safe_popen_read(bin/"imgcompress", "man")
  end

  test do
    system bin/"imgcompress", "tools", "--check" # fails if the bundled gifsicle is not found
  end
end
