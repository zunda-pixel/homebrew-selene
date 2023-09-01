class Selene < Formula
  desc "Generation Swift source code from Env file"
  homepage "https://github.com/zunda-pixel/selene"
  url "https://github.com/zunda-pixel/selene.git",
      tag:      "1.2.0",
      revision: "09c9f62d34208fdf00e18347df623f156a6da28f"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/zunda-pixel/selene.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/selene"
  end

  test do
    (testpath/".env").write <<~EOS
      key1=value1
      #key2=value2
      key3=value3=value3
    EOS
    shell_output("#{bin}/selene SecretEnv .env SecretEnv.swift")
    assert_predicate testpath/"SecretEnv.swift", :exist?
  end
end
