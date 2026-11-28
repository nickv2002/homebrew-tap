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
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.28.1/imgcompress-2026.11.28.1-macos-universal.tar.gz"
      sha256 "a255d75947049451de9a6d50ed6b498fcc6ba844099aa0abe3cd80a442409729"
    end
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.28.1/imgcompress-2026.11.28.1-macos-universal.tar.gz"
      sha256 "a255d75947049451de9a6d50ed6b498fcc6ba844099aa0abe3cd80a442409729"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.28.1/imgcompress-2026.11.28.1-linux-x86_64.tar.gz"
      sha256 "24e509ea01ef19933ef0bab26a8952130cdb205d03d9bc5a8206c18a5005cdc2"
    end
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.28.1/imgcompress-2026.11.28.1-linux-aarch64.tar.gz"
      sha256 "ecef1efaf61e99705b47a9b0bdb6783d58586e4a5e542c00324b34c7b11f764e"
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
