# Attache — Homebrew tap

Homebrew tap for [Attache](https://github.com/dasysad/attache) CLI and desktop app.

## Install

```bash
brew tap dasysad/tap
brew install attache-cli           # CLI
brew install --cask attache          # desktop (Apple Silicon, after first DMG release)
```

## Available formulae & casks

| Name | Type | Description |
|------|------|-------------|
| `attache-cli` | Formula | Household finance CLI (`attache` command) |
| `attache` | Cask | Tauri desktop shell over loopback UI |

## Desktop cask — Gatekeeper

Builds are ad-hoc signed (no Apple Developer ID yet). If macOS reports the app is damaged:

```bash
xattr -cr "/Applications/Attache.app"
# or
brew install --cask attache --no-quarantine
```

## Updates

The `attache` cask is auto-bumped when a `desktop-v*` [GitHub Release](https://github.com/dasysad/attache/releases) is published (see `.github/workflows/bump-homebrew-tap.yml` in the main repo).

Requires `HOMEBREW_TAP_TOKEN` secret on `dasysad/attache` with contents + PR write on this repo.
