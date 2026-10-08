cask "tiqdo" do
  version "1.0.0"
  sha256 "f4b05e1c6e9511cb291cba716f952699f39dd9a5515f7ba91c5209992013ad05"

  url "https://github.com/petrfilip/tiqdo/releases/download/v#{version}/Tiqdo-#{version}-source.tar.gz"
  name "Tiqdo"
  desc "Native menu bar task manager with Now, Nxt and Ltr priorities"
  homepage "https://github.com/petrfilip/tiqdo"

  depends_on macos: :sonoma

  app "Tiqdo-#{version}/.build/Tiqdo.app"
  installer script: {
    executable: "/usr/bin/env",
    args:       ["APP_VERSION=#{version}", "BUILD_NUMBER=#{version.to_s.delete(".")}",
                 "/bin/bash", "#{staged_path}/Tiqdo-#{version}/build.sh"],
  }
  binary "tiqdo"

  preflight_steps do
    write "tiqdo", <<~SH
      #!/bin/bash
      exec /usr/bin/open "{{appdir}}/Tiqdo.app" "$@"
    SH
  end

  uninstall quit: "cz.tix.tiqdo"

  caveats <<~EOS
    Tiqdo is built locally during installation.
    Apple Command Line Tools (or Xcode) are required.
    Tasks and history are preserved when uninstalling.
  EOS
end
