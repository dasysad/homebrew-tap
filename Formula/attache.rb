class Attache < Formula
  desc "Household finance CLI and agent tools"
  homepage "https://github.com/dasysad/attache"
  url "https://github.com/dasysad/attache/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ec43dc81b71a923be674397cdad6f32250e46fa1885ec3e19f6489f74d35e744"
  license "MIT"
  head "https://github.com/dasysad/attache.git", branch: "main"

  depends_on "node@22"
  depends_on "pnpm"

  def install
    ENV["PATH"] = "#{Formula["node@22"].opt_bin}:#{Formula["pnpm"].opt_bin}:#{ENV["PATH"]}"

    # pnpm v10+ blocks native postinstall scripts unless allowBuilds is set.
    workspace = buildpath/"pnpm-workspace.yaml"
    if workspace.exist? && !workspace.read.include?("allowBuilds:")
      workspace.append_lines <<~YAML

        allowBuilds:
          better-sqlite3: true
          esbuild: true
      YAML
    end

    system "pnpm", "install", "--frozen-lockfile"
    # CLI only — do not build @attache/desktop (Tauri) during brew install.
    system "pnpm", "--filter", "@attache/cli...", "build"
    bin.install "packages/cli/dist/main.js" => "attache"
  end

  test do
    assert_match "attache — household finance CLI", shell_output("#{bin}/attache")
  end
end
