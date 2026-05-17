# homebrew-cliphop

Homebrew Cask formula for [ClipHop](https://cliphop.org/) — end-to-end
encrypted clipboard sync between Android and macOS over Bluetooth Low
Energy. No cloud. No account.

## Install

```bash
brew tap anshulg8/cliphop
brew install --cask cliphop
```

Brew downloads the DMG, copies `ClipHop.app` into `/Applications`, and
strips the quarantine attribute so Gatekeeper doesn't prompt on first
launch.

## Update

```bash
brew upgrade --cask cliphop
```

ClipHop ships its own in-app updater (Sparkle) too — the menu bar's
"Check for Updates…" finds new releases without going through Brew.
Use whichever flow you prefer.

## Uninstall

```bash
brew uninstall --cask cliphop            # removes the app
brew uninstall --zap --cask cliphop      # also removes saved history + preferences
```

## Per-release maintainer checklist

`macos/scripts/release.sh` in the app repo bumps this formula
automatically when run with `--push`. The manual flow, for reference:

1. Build + host the new DMG at
   `https://cliphop.org/releases/ClipHop-X.Y.Z.dmg`.
2. Compute its SHA-256:
   ```bash
   shasum -a 256 ClipHop-X.Y.Z.dmg
   ```
3. Update `Casks/cliphop.rb`:
   - bump `version`
   - replace `sha256`
4. Commit + push. `brew upgrade --cask cliphop` picks it up on the
   user's next run.

The `livecheck` block points at the Sparkle appcast, so
`brew livecheck cliphop` will show "out of date" automatically when
the appcast announces a newer version than the cask claims.
