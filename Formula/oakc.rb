class Oakc < Formula
  desc "Portable programming language with a compact intermediate representation"
  homepage "https://github.com/adam-mcdaniel/oakc"
  url "https://static.crates.io/crates/oakc/oakc-0.6.1.crate"
  sha256 "1f4a90a3fd5c8ae32cb55c7a38730b6bfcf634f75e6ade0fd51c9db2a2431683"
  license "Apache-2.0"
  head "https://github.com/adam-mcdaniel/oakc.git", branch: "develop"

  livecheck do
    url "https://crates.io/api/v1/crates/oakc/versions"
    regex(/"num":\s*"(\d+(?:\.\d+)+)"/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b58035324817fb113cf2ed484deb7a994e0b1e0bacf8e685220944ed0aa8a35a"
    sha256 cellar: :any_skip_relocation, big_sur:       "a42a5da5666621bcaedf03d27e569bd7089aca6d35823075cf02abe49d168a19"
    sha256 cellar: :any_skip_relocation, catalina:      "d70a881ba63259365ca41b80ce29d36a7761f5af31ba92eba0f47d21bece3f3a"
    sha256 cellar: :any_skip_relocation, mojave:        "ddce9bc14e1b7067e2bf562b986e813186a448c7fbb245cb34a7867fd6a8ba30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "943bcda31af3e8260e792011b2c12ed57f8766a0aefeb3f5d7825c137aca3b63" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "tar", "--strip-components", "1", "-xzvf", "oakc-#{version}.crate"
    system "cargo", "install", *std_cargo_args
    pkgshare.install "examples"
  end

  test do
    system bin/"oak", "-c", "c", pkgshare/"examples/hello_world.ok"
    assert_equal "Hello world!\n", shell_output("./main")
    assert_match "This file tests Oak's doc subcommand",
                 shell_output("#{bin}/oak doc #{pkgshare}/examples/flags/doc.ok")
  end
end
