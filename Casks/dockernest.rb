cask "dockernest" do
  version "2026.10.06.1"
  sha256 "d7e6ca301c59ee1819b5914b2b176c863abc5309692183845b839e090a2bbfcc"

  url "https://github.com/petrfilip/homebrew-tap/releases/download/v2026.10.06.1/DockerNest-2026.10.06.1-source.tar.gz",
      verified: "github.com/petrfilip/homebrew-tap/"
  name "DockerNest"
  desc "Native macOS GUI for Docker containers and runtimes"
  homepage "https://github.com/petrfilip/homebrew-tap"

  depends_on macos: :sonoma

  # The archive includes checksum-verified SwiftTerm sources; build locally without fetching packages.
  installer script: {
    executable: "/bin/bash",
    args: ["#{staged_path}/DockerNest-2026.10.06.1/scripts/build-app.sh", "--version", version.to_s,
           "--build-number", version.to_s.delete("."), "--disable-sandbox"],
  }

  preflight_steps do
    write "dockernest", <<~SH
      #!/bin/bash
      exec /usr/bin/open "{{appdir}}/DockerNest.app" "$@"
    SH
  end

  app "DockerNest-2026.10.06.1/dist/DockerNest.app"
  binary "dockernest"

  caveats <<~EOS
    DockerNest is built locally during installation. The first install can take several minutes.
    Apple Command Line Tools (or Xcode) are required to build it.
    Install your preferred Docker runtime separately, such as Colima or Lighter.
  EOS

  zap trash: "~/Library/Preferences/cz.tix.DockerNest.plist"
end
