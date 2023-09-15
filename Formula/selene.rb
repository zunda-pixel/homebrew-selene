class Selene < Formula
  desc "Generation Swift source code from Env file"
  homepage "https://github.com/zunda-pixel/selene"
  url "https://github.com/zunda-pixel/selene.git",
      tag:      "1.2.2",
      revision: "06666d4e04f56485e04c2181bdff7bbf7b71c4db"
  license "Apache-2.0"
  head "https://github.com/zunda-pixel/selene.git", branch: "main"

  depends_on xcode: ["14.3", :build]

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
