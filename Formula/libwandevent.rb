class Libwandevent < Formula
  desc "API for developing event-driven programs"
  homepage "https://research.wand.net.nz/software/libwandevent.php"
  url "https://research.wand.net.nz/software/libwandevent/libwandevent-3.0.2.tar.gz"
  sha256 "48fa09918ff94f6249519118af735352e2119dc4f9b736c861ef35d59466644a"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?libwandevent[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "57f916a1558f5b44462c12c98260ab27d0b4c5dd6b9df9502d9d8d19a480e437"
    sha256 cellar: :any, big_sur:       "651aea239dab48e29f473c5a181f9dad8420350672a99e063419974599e26674"
    sha256 cellar: :any, catalina:      "f175ecabb18921593ddd08bbd0b2aaa5e0a24c85d2964be230cd3a1f0ede22ee"
    sha256 cellar: :any, mojave:        "1e1db4ade4de58ab9ca1f0545d91537b935b65e062d99737c288dd059a17da8e"
    sha256 cellar: :any, high_sierra:   "7593e96a9e76e4b67fa3851a3491c8d7cbd458ad53ff65b3a34b64e2f697e75b"
    sha256 cellar: :any, sierra:        "e4b00ade9387b8fdccf72bbe9edd0e334c69f23597f85dd1e6da02088703c286"
    sha256 cellar: :any, el_capitan:    "f1459d39284b520c17443c6bef5ccb641dfe1e20266a4f34071f6a87cd9669e4"
    sha256 cellar: :any, yosemite:      "b8c90b8dca1d0ded39036d7f23b4e33857c7914e178ba8ac8870ab702f96fa04"
    sha256 cellar: :any, x86_64_linux:  "0059a328c6e1ce3b54bf269fb06f933209a0afaa9eee2659ccc2bbb4c0c16d74" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <sys/time.h>
      #include <libwandevent.h>

      int main() {
        wand_event_init();
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lwandevent", "-o", "test"
    system "./test"
  end
end
