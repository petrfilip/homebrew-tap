# Homebrew Tap

Homebrew tap for Petr Filip tools and macOS apps.

## Tiqdo

[Tiqdo](https://github.com/petrfilip/tiqdo) is a native macOS menu bar task manager
with Now / Nxt / Ltr priorities, multiple tabs, and local task history.

![Tiqdo task manager with Now, Nxt and Ltr lanes](assets/tiqdo.png)

### Install and launch

Requires macOS 14 or later, Homebrew, and Apple Command Line Tools (or Xcode).
Homebrew builds and ad-hoc signs the app locally from a checksum-verified source
archive. Apple Silicon and Intel Macs are supported; no additional Swift packages
or Apple Developer Program membership are required.

```bash
brew install --cask petrfilip/tap/tiqdo
open /Applications/Tiqdo.app
```

If you previously installed with Tiqdo's `./build.sh --install`, quit the app
and remove only the old `/Applications/Tiqdo.app` symlink before installing.

### Update and uninstall

```bash
brew update
brew upgrade --cask tiqdo
brew uninstall --cask tiqdo
```

Uninstalling preserves tasks and history in `~/Library/Application Support/Tiqdo`.
Versioned source archives are published in
[Tiqdo's GitHub Releases](https://github.com/petrfilip/tiqdo/releases).
Tiqdo is licensed under MIT.

## DockerNest

Native macOS GUI for Docker containers and runtimes, including
[Lighter](https://github.com/fieldwork-ai/lighter) and
[Colima](https://github.com/abiosoft/colima).

![DockerNest running with the Lighter runtime](assets/dockernest.png)

### Install and launch

Requires macOS 14 or later, Homebrew, and Apple Command Line Tools (or Xcode). Homebrew downloads
verified source archives and builds the app locally. No Apple Developer Program
membership is required. The first installation can take several minutes.

```bash
brew install petrfilip/tap/dockernest
dockernest
```

Choose a runtime and install its tools separately:

**[Lighter](https://github.com/fieldwork-ai/lighter)** — requires Apple Silicon and macOS 15 or later.

```bash
brew tap fieldwork-ai/tap
brew install lighter docker docker-compose
```

**[Colima](https://github.com/abiosoft/colima)**:

```bash
brew install colima docker docker-compose
```

DockerNest is automatically installed in `/Applications` and is available in
Finder, Spotlight, and Launchpad. No manual link or extra installation step is needed.

### Update and uninstall

```bash
brew update
brew upgrade dockernest
brew uninstall dockernest
```

Uninstalling removes the application and its launcher. Homebrew also removes its build sources.

If you installed the older formula, `brew update` recognizes the migration to a
cask. Remove the old formula when prompted by Homebrew.

### Releases

Versioned source archives and their SHA-256 checksums are published in this
repository's [GitHub Releases](https://github.com/petrfilip/homebrew-tap/releases).
The cask pins its source archive by checksum, including the verified SwiftTerm
library sources. The app is built and ad-hoc signed on the installing computer.
No additional Swift packages are downloaded during installation.

DockerNest is licensed under MIT; the source archive includes its license.
