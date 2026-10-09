cask "dockernest" do
  version "2026.10.09.2"
  sha256 "7ddc92c2949757381fb8967f212220e7628cfe6fce5bb13405d261d0f4166b36"

  url "https://github.com/petrfilip/homebrew-tap/releases/download/v2026.10.09.2/DockerNest-2026.10.09.2-source.tar.gz",
      verified: "github.com/petrfilip/homebrew-tap/"
  name "DockerNest"
  desc "Native macOS GUI for Docker containers and runtimes"
  homepage "https://github.com/petrfilip/homebrew-tap"

  depends_on macos: :sonoma

  # The archive includes checksum-verified SwiftTerm sources; build locally without fetching packages.
  installer script: {
    executable: "/bin/bash",
    args: ["#{staged_path}/DockerNest-2026.10.09.2/scripts/build-app.sh", "--version", version.to_s,
           "--build-number", version.to_s.delete("."), "--disable-sandbox"],
  }

  preflight_steps do
    write "dockernest", <<~SH
      #!/bin/bash
      exec /usr/bin/open "{{appdir}}/DockerNest.app" "$@"
    SH
  end

  app "DockerNest-2026.10.09.2/dist/DockerNest.app"
  binary "dockernest"

  caveats <<~EOS
    DockerNest is built locally during installation. The first install can take several minutes.
    Apple Command Line Tools (or Xcode) are required to build it.
    Install your preferred Docker runtime separately, such as Colima or Lighter.
  EOS

  zap trash: "~/Library/Preferences/cz.tix.DockerNest.plist"
end
