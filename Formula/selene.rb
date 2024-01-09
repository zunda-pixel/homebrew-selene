class Selene < Formula
  desc "Generation Swift source code from Env file"
  homepage "https://github.com/zunda-pixel/selene"
  url "https://github.com/zunda-pixel/selene.git",
      tag:      "1.2.3",
      revision: "18cd92b578ed84e4529ba25763feda7a36007ae2"
  license "Apache-2.0"
  head "https://github.com/zunda-pixel/selene.git", branch: "main"

  depends_on xcode: ["15.2", :build]

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
