class Eureka < Formula
  desc "CLI tool to input and store your ideas without leaving the terminal"
  homepage "https://github.com/simeg/eureka"
  url "https://github.com/simeg/eureka/archive/v1.8.1.tar.gz"
  sha256 "d10d412c71dea51b4973c3ded5de1503a4c5de8751be5050de989ac08eb0455e"
  license "MIT"
  head "https://github.com/simeg/eureka.git"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "528bd9719bd743bbe9e496ca2c856983c8acdf89fbf4364a6a1a349c8560aff1"
    sha256 cellar: :any,                 big_sur:       "3447e5073ee6dd2026b39fcc2dac86465806fa57a263127b92d672a142efcbfe"
    sha256 cellar: :any,                 catalina:      "616a745506e35e1ab0a7645d7d122f204cbf94e292d2fc56958795a056af0a9a"
    sha256 cellar: :any,                 mojave:        "998ed401c748a0916768a566ccf44e4295c56cd6f23a90b156087588f23e7e2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10a4686e41cb3bc18974d558899493bc13aeffb51590ff0cbdb0e8668d120cd5" # linuxbrew-core
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "eureka [FLAGS]", shell_output("#{bin}/eureka --help 2>&1")

    (testpath/".eureka/repo_path").write <<~EOS
      homebrew
    EOS

    assert_match "homebrew/README.md: No such file or directory", pipe_output("#{bin}/eureka --view 2>&1")
  end
end
