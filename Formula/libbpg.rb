class Libbpg < Formula
  desc "Image format meant to improve on JPEG quality and file size"
  homepage "http://bellard.org/bpg/"
  url "http://bellard.org/bpg/libbpg-0.9.6.tar.gz"
  sha256 "2800777d88a77fd64a4a9036b131f021a5bda8304e1dbe7996dd466567fb484e"

  bottle do
    cellar :any
    sha256 "98b771795e3f03995005af5f26d3c74bd178a6f2bc69b41a8e35fe735c95b765" => :el_capitan
    sha256 "d5d9b76f692ead22f64e84c1ca9bdf11877d6bc249d92bad98f8a11ce3120106" => :yosemite
    sha256 "7b8d1585ee9e2de010abfab1aaab419d052cf35d82704587c2f75947d4fc8ee5" => :mavericks
  end

  option "with-jctvc", "Enable built-in JCTVC encoder - Mono threaded, slower but produce smaller file"
  option "without-x265", "Disable built-in x265 encoder - Multi threaded, faster but produce bigger file"

  depends_on "cmake" => :build
  depends_on "yasm" => :build if build.with? "x265"
  depends_on "libpng"
  depends_on "jpeg"

  def install
    bin.mkpath

    args = []
    args << "USE_JCTVC=y" if build.with? "jctvc"
    args << "USE_X265=" if build.without? "x265"

    system "make", "install", "prefix=#{prefix}", "CONFIG_APPLE=y", *args
  end

  test do
    system "#{bin}/bpgenc", test_fixtures("test.png")
  end
end
