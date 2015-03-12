require 'formula'

class Tmux19a1 < Formula
  homepage 'https://github.com/markeissler/homebrew-tmux-19a1'
  url 'https://github.com/markeissler/tmux/archive/1.9a1.tar.gz'
  sha1 '137f3907c161799f02828b603ce2e4f21b147749'

  # bottle do
  #   cellar :any
  #   revision 1
  #   sha1 "5a5e180e33339671bc8c82ed58c26862da037f30" => :yosemite
  #   sha1 "6092f92f5cd7eeb6ddf3b555cd4e655c4c85e826" => :mavericks
  #   sha1 "981c8c199a2ea3df18b6651205b4616459ae1f8c" => :mountain_lion
  # end

  # force tap build vs pouring a dist bottle
  def pour_bottle?
    false
  end

  head do
    url 'https://github.com/markeissler/homebrew-tmux-19a1.git'

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on 'pkg-config' => :build
  depends_on 'libevent'

  # patch bash completion for our path?
  # patch :p0 do
  #   url "https://trac.macports.org/export/110576/trunk/dports/lang/gcc43/files/darwin10.diff"
  #   sha1 "4119006a1fa18086431d3204db440750af668783"
  # end

  def install
    system "sh", "autogen.sh" if build.head?

    ENV.append "LDFLAGS", '-lresolv'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make install"

    bash_completion.install "examples/bash_completion_tmux.sh" => 'tmux'
    (share/'tmux').install "examples"
  end

  def caveats; <<-EOS.undent
    Example configurations have been installed to:
      #{share}/tmux/examples
    EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
