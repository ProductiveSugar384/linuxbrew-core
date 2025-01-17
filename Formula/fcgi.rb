class Fcgi < Formula
  desc "Protocol for interfacing interactive programs with a web server"
  # Last known good original homepage: https://web.archive.org/web/20080906064558/www.fastcgi.com/
  homepage "https://fastcgi-archives.github.io/"
  url "https://github.com/FastCGI-Archives/fcgi2/archive/2.4.2.tar.gz"
  sha256 "1fe83501edfc3a7ec96bb1e69db3fd5ea1730135bd73ab152186fd0b437013bc"
  license "OML"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "f690a0cd985561930532baa0676c10f954f5c4d3500a8ec40733a28debfd0656"
    sha256 cellar: :any, big_sur:       "62ab01d728067324cc5466d20d28e6a6920514c0a1f379df290cbc3b79cb442d"
    sha256 cellar: :any, catalina:      "3905f7f3dec32a296b831f224a4f2cc75089c60b8a0137ce0b25e37466ffba8a"
    sha256 cellar: :any, mojave:        "a43c52588cc652fcc1d9be4d89393212875732349bd4dbdda4068f985db10628"
    sha256 cellar: :any, high_sierra:   "3ee3183f46dd8f38eee932f685e8d6a52fd0c0c2a1797bb25d62ad973b1405ed"
    sha256 cellar: :any, x86_64_linux:  "34b4284647f1a97bf53cf1d039a20bf326f77885e8b1d4c39e62bdf8c7e88d4e" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"testfile.c").write <<~EOS
      #include "fcgi_stdio.h"
      #include <stdlib.h>
      int count = 0;
      int main(void){
        while (FCGI_Accept() >= 0){
        printf("Request number %d running on host %s", ++count, getenv("SERVER_HOSTNAME"));}}
    EOS
    system ENV.cc, "testfile.c", "-L#{lib}", "-lfcgi", "-o", "testfile"
    assert_match "Request number 1 running on host", shell_output("./testfile")
  end
end
