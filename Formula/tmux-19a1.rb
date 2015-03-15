require 'formula'

class Tmux19a1 < Formula
  homepage 'https://github.com/markeissler/tmux-19a1'
  url 'http://dl.bintray.com/markeissler/homebrew/tmux-19a1/tmux-19a1.tar.gz'
  sha256 '2e187f02411ce6c3247f75223e62db24ae03215d8da452b4448d3fdc0d6f0d03'

  bottle do
    root_url 'http://dl.bintray.com/markeissler/homebrew/tmux-19a1'
    cellar :any
    sha256 "678fc45cc513a5fe7f2c91f24de360d6f2e1a67c5a789b6ce958624b8b7f8a6b" => :yosemite
    sha256 'b9cef372d7ca64cc2b961c625ecaa43b9361df4d0d021710add1b96aae8a019e' => :mavericks
    sha256 "07b7932b52725d4ba3dcf5f02c654f890568827fe56d4c132752753dc4445ef6" => :mountain_lion
  end

  head do
    url 'https://github.com/markeissler/tmux.git', :branch => 'me/statusline-shellcmd-var-substitution'

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on 'pkg-config' => :build
  depends_on 'libevent'

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
