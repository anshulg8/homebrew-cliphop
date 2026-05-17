cask "cliphop" do
  version "0.1.0"
  sha256 "96bb5eb54988152c27f049f6c2f8382db4ccf5b10fad1da5803db3f6ce328697"

  url "https://cliphop.org/releases/ClipHop-#{version}.dmg",
      verified: "cliphop.org/"
  name "ClipHop"
  desc "End-to-end encrypted clipboard sync between Android and macOS over BLE"
  homepage "https://cliphop.org/"

  # Sparkle's appcast feed exposes the current shipped version, so
  # `brew livecheck cliphop` (and `brew update`) pick up new releases
  # without manual cask edits between maintainer pushes.
  livecheck do
    url "https://cliphop.org/appcast.xml"
    strategy :sparkle
  end

  app "ClipHop.app"

  # Brew Cask adds com.apple.quarantine to installed apps by default,
  # which makes Gatekeeper block ad-hoc-signed binaries on first launch.
  # Strip it explicitly so users don't need --no-quarantine on the
  # command line. Once ClipHop is notarized this block can be removed.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClipHop.app"]
  end

  # `brew uninstall --zap --cask cliphop` removes user data too.
  # Without --zap, uninstall just removes the .app and leaves data
  # alone — matching what most users expect when reinstalling.
  zap trash: [
    "~/Library/Application Support/org.cliphop.app",
    "~/Library/Caches/org.cliphop.app",
    "~/Library/Preferences/org.cliphop.app.plist",
    "~/Library/HTTPStorages/org.cliphop.app",
  ]
end
