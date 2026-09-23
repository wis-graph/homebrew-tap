class Desklog < Formula
  desc "Records what you do at your desk as time spans in a local sqlite file"
  homepage "https://github.com/wis-graph/desklog"
  url "https://github.com/wis-graph/desklog/releases/download/v0.5.2/desklog-0.5.2-macos-universal.tar.gz"
  sha256 "26ce7293ce97a5c27a1fb2925fa5a7478c053fcfc08f684f3dd0f4ba5efd9ae3"
  version "0.5.2"
  license "MIT"

  # 미리 빌드해 Developer ID 로 서명·공증한 .app 번들을 받는다.
  # 단독 실행파일이면 화면 기록 권한(TCC)을 판마다 다시 묻는다 — 번들이라야 식별자로 묶인다.
  depends_on :macos

  def install
    libexec.install "desklog.app"
    # CLI 는 번들 안 실행파일을 가리킨다. TCC 는 이 실행파일에서 번들을 거슬러 올라
    # 안정적인 번들 식별자로 권한을 묶으므로, 판을 올려도 항목이 하나로 유지된다.
    bin.install_symlink libexec/"desklog.app/Contents/MacOS/desklog"
  end

  service do
    run [opt_libexec/"desklog.app/Contents/MacOS/desklog", "watch"]
    keep_alive true
    log_path var/"log/desklog.log"
    error_log_path var/"log/desklog.log"
  end

  test do
    assert_match "desklog", shell_output("#{bin}/desklog --version")
    assert_match "watch", shell_output("#{bin}/desklog --help")
  end
end
