class Largetifftools < Formula
  desc "Process very large TIFF files"
  homepage "https://www.imnc.in2p3.fr/pagesperso/deroulers/software/largetifftools/"
  url "https://www.imnc.in2p3.fr/pagesperso/deroulers/software/largetifftools/download/largetifftools-1.3.10/largetifftools-1.3.10.tar.bz2"
  sha256 "283233b7ce9baadc767d82a249c035134760432f1511affce47fbc8cb7a2a397"

  depends_on "libpng" => :build
  depends_on "libtiff" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/tifffastcrop", "--version"
  end
end
