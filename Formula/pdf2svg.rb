class Pdf2svg < Formula
  desc "PDF converter to SVG"
  homepage "https://cityinthesky.co.uk/opensource/pdf2svg"
  url "https://github.com/db9052/pdf2svg/archive/v0.2.3.tar.gz"
  sha256 "4fb186070b3e7d33a51821e3307dce57300a062570d028feccd4e628d50dea8a"
  license "GPL-2.0"
  revision 6

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "dc5018cf8ccb7b474fe5c575d562c59e361c3c251ce88d9e36b7636d1f77ef3b"
    sha256 cellar: :any,                 big_sur:       "3a8d825e70e419c4f7cc783d472eec8cd384764c351c131780c2a0b691cda24d"
    sha256 cellar: :any,                 catalina:      "a2af2e44c752994638edbd3aa7684290d116d20f1da2fe3e4490527be5b23bac"
    sha256 cellar: :any,                 mojave:        "b0cf8046c13335a16496cc5601af7a82f14b45c866cf9f3ae9072075ccc867fe"
    sha256 cellar: :any,                 x86_64_linux:  "98a0e701b595abda653f23e02b7247c858b3ad8290ae70d4c562a1aa6f247e8f" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "poppler"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pdf2svg", test_fixtures("test.pdf"), "test.svg"
  end
end
