# Homebrew Tap

Homebrew tap for Petr Filip tools and macOS apps.

## DockerNest

Native macOS GUI for Docker containers and runtimes, including Colima and Lighter.

### Install and launch

Requires macOS 14 or later, Homebrew, and Xcode 15 or later. Homebrew downloads
verified source archives and builds the app locally. No Apple Developer Program
membership is required. The first installation can take several minutes.

```bash
brew install petrfilip/tap/dockernest
dockernest
```

Install runtime tools separately, for example:

```bash
brew install colima docker docker-compose
```

For Lighter instead, use `brew tap fieldwork-ai/tap` and `brew install lighter`
(Lighter requires Apple Silicon and macOS 15 or later).

### Spotlight and Launchpad

```bash
mkdir -p ~/Applications
ln -s "$(brew --prefix dockernest)/libexec/DockerNest.app" ~/Applications/DockerNest.app
```

### Update and uninstall

```bash
brew update
brew upgrade dockernest
brew uninstall dockernest
```

If you created the optional Spotlight link, remove `~/Applications/DockerNest.app`
after uninstalling the package.

### Releases

Versioned source archives and their SHA-256 checksums are published in this
repository's [GitHub Releases](https://github.com/petrfilip/homebrew-tap/releases).
Each formula pins the archive and SwiftTerm dependency by checksum. The app is
built and ad-hoc signed on the installing computer.

DockerNest is licensed under MIT; the source archive includes its license.
