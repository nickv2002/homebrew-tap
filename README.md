# nickv2002/homebrew-tap

Homebrew packages for Nick Vance's apps and tools.

| Package | Kind | What it is |
|---|---|---|
| `imagecompress` | cask (macOS, from its first release) | [ImageCompress](https://nickv2002.github.io/ImageCompress/): compress and convert images from a native Mac app, the Finder menu or the command line. Includes the `imgcompress` command. |
| `imgcompress` | formula (macOS, Linux, from its first release) | The ImageCompress command-line tool on its own. |
| `transmission-remote` | cask (macOS) | [Transmission Remote](https://github.com/nickv2002/Transmission-Remote-MacOS): a native remote for Transmission servers. |
| `md-tools` | cask (macOS arm64, Linux) | [md-tools](https://github.com/nickv2002/md-tools): `mdunwrap` and `md2mkdwn`. |

## Install

```bash
brew tap nickv2002/tap
brew trust --cask nickv2002/tap/imagecompress   # once per package (or `brew trust --tap nickv2002/tap` for all)
brew install --cask imagecompress
```

Swap in the package you want: `brew install --cask transmission-remote`, `brew install --cask md-tools`, or the CLI-only formula
`brew trust --formula nickv2002/tap/imgcompress && brew install imgcompress`.

The Mac apps update themselves through Sparkle, so `brew upgrade` leaves them alone (`auto_updates true`). The `imagecompress`
cask and the `imgcompress` formula both install an `imgcompress` command, so install one or the other.

## Maintenance

ImageCompress's release script (`scripts/update_tap.sh`) updates `Casks/imagecompress.rb` and `Formula/imgcompress.rb`
with the new version and SHA-256, and pushes. `transmission-remote` and `md-tools` are updated by hand for now, until
their release scripts write here too.
