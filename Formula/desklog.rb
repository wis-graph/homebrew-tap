class Desklog < Formula
  desc "Records what you do at your desk as time spans in a local sqlite file"
  homepage "https://github.com/wis-graph/desklog"
  url "https://github.com/wis-graph/desklog/releases/download/v0.3.1/desklog-0.3.1-macos-universal.tar.gz"
  sha256 "4e18f13b67308c2dcb451ff991ebbe897cd73f9d3c6bc2d2db21209e7e842714"
  version "0.3.1"
  license "MIT"

  # 미리 빌드해 Developer ID 로 서명·공증한 universal 바이너리를 받는다.
  # 소스 빌드로 바꾸면 서명이 사라지고 화면 기록 권한을 판마다 다시 묻게 된다.
  depends_on :macos

  def install
    bin.install "desklog"
  end

  service do
    run [opt_bin/"desklog", "watch"]
    keep_alive true
    log_path var/"log/desklog.log"
    error_log_path var/"log/desklog.log"
  end

  test do
    assert_match "desklog", shell_output("#{bin}/desklog --version")
    assert_match "watch", shell_output("#{bin}/desklog --help")
  end
end
