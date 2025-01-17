class Srt < Formula
  desc "Secure Reliable Transport"
  homepage "https://www.srtalliance.org/"
  url "https://github.com/Haivision/srt/archive/v1.4.4.tar.gz"
  sha256 "93f5f3715bd5bd522b8d65fc0d086ef2ad49db6a41ad2d7b35df2e8bd7094114"
  license "MPL-2.0"
  head "https://github.com/Haivision/srt.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "7f19f11cb0131e7fe95bf612906b40e00fc8c941f80d294eac2f80850c88ced9"
    sha256 cellar: :any,                 big_sur:       "1feec9a3449db0914403420eddd731dc17bd2df8fce2b0471227c79e8e7688f9"
    sha256 cellar: :any,                 catalina:      "078b246649eed71dc3eed9d8d3e2d71b2ce025ecf5933fdc33956f6582251b96"
    sha256 cellar: :any,                 mojave:        "7308578774fd1cdfed6c250044bf013e2b188c19d866ba114fe02c505ae92303"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6cb379f1edd822387425ca2b6463b42c23b0046f6bc50004ce0f63f8cbffb031" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"

  def install
    openssl = Formula["openssl@1.1"]
    system "cmake", ".", "-DWITH_OPENSSL_INCLUDEDIR=#{openssl.opt_include}",
                         "-DWITH_OPENSSL_LIBDIR=#{openssl.opt_lib}",
                         "-DCMAKE_INSTALL_BINDIR=bin",
                         "-DCMAKE_INSTALL_LIBDIR=lib",
                         "-DCMAKE_INSTALL_INCLUDEDIR=include",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    cmd = "#{bin}/srt-live-transmit file:///dev/null file://con/ 2>&1"
    assert_match "Unsupported source type", shell_output(cmd, 1)
  end
end
