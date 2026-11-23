cask "imagecompress" do
  version "2026.11.23.1"
  sha256 "fa62b099a78dfa5f2e856387525c69b6bb945fc6e37520640374258db41dbc03"

  url "https://github.com/nickv2002/ImageCompress/releases/download/v#{version}/ImageCompress-#{version}.zip"
  name "ImageCompress"
  desc "Compress and convert images from an app, the Finder menu or the command-line"
  homepage "https://nickv2002.github.io/ImageCompress/"

  livecheck do
    url "https://nickv2002.github.io/ImageCompress/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "ImageCompress.app"
  # The engine finds its bundled gifsicle through this link (it resolves its own path).
  binary "#{appdir}/ImageCompress.app/Contents/MacOS/imgcompress"

  zap trash: [
    "~/Library/Application Support/ImageCompress",
    "~/Library/Caches/com.nickvance.imagecompress",
    "~/Library/Group Containers/3D9SMH4RWM.com.nickvance.imagecompress",
    "~/Library/HTTPStorages/com.nickvance.imagecompress",
    "~/Library/Preferences/com.nickvance.imagecompress.plist",
    "~/Library/Saved Application State/com.nickvance.imagecompress.savedState",
  ]
end
