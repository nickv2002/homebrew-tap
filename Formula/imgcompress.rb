class Imgcompress < Formula
  desc "Compress and convert PNG, JPEG, WebP, GIF, AVIF, JPEG XL and HEIC images"
  homepage "https://nickv2002.github.io/ImageCompress/"
  version "2026.11.22.1"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # One universal tarball serves both Mac architectures.
  on_macos do
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v#{version}/imgcompress-#{version}-macos-universal.tar.gz"
      sha256 "d7f59b86b0690c839f5b36a4cae55e02cb12074ba98cd86c5762d2d05f0971e6"
    end
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v#{version}/imgcompress-#{version}-macos-universal.tar.gz"
      sha256 "d7f59b86b0690c839f5b36a4cae55e02cb12074ba98cd86c5762d2d05f0971e6"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v#{version}/imgcompress-#{version}-linux-x86_64.tar.gz"
      sha256 "17996430a7452a8972733c700c1c3f023d17d06c9cfefe3079da8de5abb68cc7"
    end
    on_arm do
      url "https://github.com/nickv2002/ImageCompress/releases/download/v#{version}/imgcompress-#{version}-linux-aarch64.tar.gz"
      sha256 "49ce2ebaabfdcc20f24fc91e23e0e8b6ef140fdc1321bfc9af753d852bf5e3f6"
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
