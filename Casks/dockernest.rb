cask "dockernest" do
  version "2026.10.13"
  sha256 "82294b0cd37504a5a9d404151e6da8df106d681759331e05a105527a31831e95"

  url "https://github.com/petrfilip/homebrew-tap/releases/download/v2026.10.13/DockerNest-2026.10.13-source.tar.gz",
      verified: "github.com/petrfilip/homebrew-tap/"
  name "DockerNest"
  desc "Native macOS GUI for Docker containers and runtimes"
  homepage "https://github.com/petrfilip/homebrew-tap"

  depends_on macos: :sonoma

  # The archive includes checksum-verified SwiftTerm sources; build locally without fetching packages.
  installer script: {
    executable: "/bin/bash",
    args: ["#{staged_path}/DockerNest-2026.10.13/scripts/build-app.sh", "--version", version.to_s,
           "--build-number", version.to_s.delete("."), "--disable-sandbox"],
  }

  preflight_steps do
    write "dockernest", <<~SH
      #!/bin/bash
      exec /usr/bin/open "{{appdir}}/DockerNest.app" "$@"
    SH
  end

  app "DockerNest-2026.10.13/dist/DockerNest.app"
  binary "dockernest"

  caveats <<~EOS
    DockerNest is built locally during installation. The first install can take several minutes.
    Apple Command Line Tools (or Xcode) are required to build it.
    Install your preferred Docker runtime separately, such as Colima or Lighter.
  EOS

  zap trash: "~/Library/Preferences/cz.tix.DockerNest.plist"
end
