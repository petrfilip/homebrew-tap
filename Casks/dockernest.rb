cask "dockernest" do
  version "2026.10.09"
  sha256 "f23b48a0105da8bd5407b6bcf00c2459581ac4538ffb34acd123b96c5c07ba01"

  url "https://github.com/petrfilip/homebrew-tap/releases/download/v2026.10.09/DockerNest-2026.10.09-source.tar.gz",
      verified: "github.com/petrfilip/homebrew-tap/"
  name "DockerNest"
  desc "Native macOS GUI for Docker containers and runtimes"
  homepage "https://github.com/petrfilip/homebrew-tap"

  depends_on macos: :sonoma

  # The archive includes checksum-verified SwiftTerm sources; build locally without fetching packages.
  installer script: {
    executable: "/bin/bash",
    args: ["#{staged_path}/DockerNest-2026.10.09/scripts/build-app.sh", "--version", version.to_s,
           "--build-number", version.to_s.delete("."), "--disable-sandbox"],
  }

  preflight_steps do
    write "dockernest", <<~SH
      #!/bin/bash
      exec /usr/bin/open "{{appdir}}/DockerNest.app" "$@"
    SH
  end

  app "DockerNest-2026.10.09/dist/DockerNest.app"
  binary "dockernest"

  caveats <<~EOS
    DockerNest is built locally during installation. The first install can take several minutes.
    Apple Command Line Tools (or Xcode) are required to build it.
    Install your preferred Docker runtime separately, such as Colima or Lighter.
  EOS

  zap trash: "~/Library/Preferences/cz.tix.DockerNest.plist"
end
