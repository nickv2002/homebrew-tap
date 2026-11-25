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
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.25.1/imgcompress-2026.11.25.1-macos-universal.tar.gz"
      sha256 "0bfd1ca22a9478369fab9be5e0d96eadf650767c69c232ff279cdbddd83fe2f0"
    end
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.25.1/imgcompress-2026.11.25.1-macos-universal.tar.gz"
      sha256 "0bfd1ca22a9478369fab9be5e0d96eadf650767c69c232ff279cdbddd83fe2f0"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.25.1/imgcompress-2026.11.25.1-linux-x86_64.tar.gz"
      sha256 "178f9874ceb125504145c2052665b1f05a01201f15083a68da67e81dc563da89"
    end
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v2026.11.25.1/imgcompress-2026.11.25.1-linux-aarch64.tar.gz"
      sha256 "813856f45aba5f1415439c66653b130d16febca6cd2c425e3aa0ec708706c039"
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
