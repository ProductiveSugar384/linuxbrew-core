class Rasqal < Formula
  desc "RDF query library"
  homepage "https://librdf.org/rasqal/"
  url "https://download.librdf.org/source/rasqal-0.9.33.tar.gz"
  sha256 "6924c9ac6570bd241a9669f83b467c728a322470bf34f4b2da4f69492ccfd97c"

  livecheck do
    url :homepage
    regex(/href=.*?rasqal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "36d9d4a210921573c1cad68bc17bf0d0fced251de091855ce1b61cefc64a37c8"
    sha256 cellar: :any, big_sur:       "14c26a4f0d108107281be78dbca4948b52a3ff157fb2dd33bdc123b2a467c492"
    sha256 cellar: :any, catalina:      "c815139d0154570fcab0e42ce7244682d13c47c4d4102b61260ffd1d0694d218"
    sha256 cellar: :any, mojave:        "61669830b056a2d79757a38bdaa53ea52c6bb84e58dfcff75804252fa12c752e"
    sha256 cellar: :any, high_sierra:   "c9a39d850c71f2ffcc6d0368cb9f575df1a0bd727992dfb553baccc8ecec97ce"
    sha256 cellar: :any, sierra:        "8d57d6803a7323f9e13c45d56b3cea41f71f7dc7cab493ddf9b34d0a2a6b68f5"
    sha256 cellar: :any, el_capitan:    "fa7368eb30256eb80ead76f7b551bc5980ed15ae8aa655d332a200edb073c2a3"
    sha256 cellar: :any, yosemite:      "c84ec1a4c837b4a30fe597c9cc728f5075764b87978c5977757e2836db3eca0b"
    sha256 cellar: :any, x86_64_linux:  "64bb0e2402fb5667201207d1499b880dbea2add73bd00ca47d32d5f3b42fbe33" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "raptor"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-html-dir=#{share}/doc",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end
