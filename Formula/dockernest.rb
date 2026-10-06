class Dockernest < Formula
  desc "Native macOS GUI for Docker containers and runtimes"
  homepage "https://github.com/petrfilip/homebrew-tap"
  url "https://github.com/petrfilip/homebrew-tap/releases/download/v2026.10.06/DockerNest-2026.10.06-source.tar.gz"
  version "2026.10.06"
  sha256 "83c9536e8ebe30c4caf9f4e7b600b5886e1fd78bb979b53fd9bd51c0cfd6b77c"
  license "MIT"

  depends_on macos: :sonoma
  depends_on xcode: ["15.0", :build]

  resource "swiftterm" do
    url "https://github.com/migueldeicaza/SwiftTerm/archive/8e7a1e154f470e19c709a00a8768df348ba5fc43.tar.gz"
    sha256 "bcb33ca794ba09b0da89ec45939e3b970d7a97df43e7a8c1dba5f0292f65ce0b"
  end

  def install
    resource("swiftterm").stage buildpath/"Vendor/SwiftTerm"
    # Only the library is needed; upstream's tools and benchmarks have extra dependencies.
    File.write(buildpath/"Vendor/SwiftTerm/Package.swift", <<~SWIFT)
      // swift-tools-version: 5.9
      import PackageDescription
      let package = Package(
        name: "SwiftTerm",
        platforms: [.macOS(.v13)],
        products: [.library(name: "SwiftTerm", targets: ["SwiftTerm"])],
        targets: [.target(
          name: "SwiftTerm",
          exclude: ["Mac/README.md"],
          resources: [.copy("Apple/Metal/Shaders.metal")]
        )]
      )
    SWIFT
    # In an installed .app, resources belong in Contents/Resources for code signing.
    inreplace "Vendor/SwiftTerm/Sources/SwiftTerm/Apple/Metal/MetalTerminalRenderer.swift",
              "bundles.append(Bundle.module)", <<~SWIFT.strip
                if let resourceURL = Bundle.main.resourceURL,
                   let resources = Bundle(url: resourceURL.appendingPathComponent("SwiftTerm_SwiftTerm.bundle")) {
                    bundles.append(resources)
                } else {
                    bundles.append(Bundle.module)
                }
              SWIFT
    inreplace "Package.swift",
              '.package(url: "https://github.com/migueldeicaza/SwiftTerm", from: "1.13.0")',
              '.package(path: "Vendor/SwiftTerm")'
    rm "Package.resolved"
    ENV["SWIFTPM_MODULECACHE_OVERRIDE"] = (buildpath/".module-cache").to_s
    ENV["CLANG_MODULE_CACHE_PATH"] = (buildpath/".module-cache").to_s
    system "bash", "scripts/build-app.sh", "--version", version.to_s,
           "--build-number", version.to_s.delete("."), "--disable-sandbox"
    libexec.install "dist/DockerNest.app"
    pkgshare.install "Vendor/SwiftTerm/LICENSE" => "SwiftTerm-LICENSE"
    bin.mkpath
    (bin/"dockernest").write <<~SH
      #!/bin/bash
      exec /usr/bin/open "#{opt_libexec}/DockerNest.app" "$@"
    SH
    chmod 0755, bin/"dockernest"
  end

  def caveats
    <<~EOS
      Launch the app with:
        dockernest

      To add it to Spotlight and Launchpad, create a symlink:
        mkdir -p ~/Applications
        ln -s "#{opt_libexec}/DockerNest.app" ~/Applications/DockerNest.app

      Install your preferred runtime separately, for example:
        brew install colima docker docker-compose
    EOS
  end

  test do
    app = libexec/"DockerNest.app"
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", app
    assert Dir.glob("#{app}/Contents/Resources/SwiftTerm_SwiftTerm.bundle/**/Shaders.metal").any?
    assert_match "All sanity checks passed.", shell_output("#{app}/Contents/MacOS/DockerNest --sanity")
  end
end
