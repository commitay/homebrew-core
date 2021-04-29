class Docfx < Formula
  desc "Tools for building and publishing API documentation for .NET projects"
  homepage "https://dotnet.github.io/docfx/"
  url "https://github.com/dotnet/docfx/releases/download/v2.56.7/docfx.zip"
  sha256 "95f96be280998e7ea6581d418c9b0d99dffb0c86bcca7f1dd257062163e0a79c"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "e1d454227a7f161c22bac66a7e29923dd20aaebe3492f84fa44be951683a3e81"
  end

  depends_on arch: :x86_64
  depends_on "mono"

  def install
    libexec.install Dir["*"]

    (bin/"docfx").write <<~EOS
      #!/bin/bash
      mono #{libexec}/docfx.exe "$@"
    EOS
  end

  test do
    system bin/"docfx", "init", "-q"
    assert_predicate testpath/"docfx_project/docfx.json", :exist?,
                     "Failed to generate project"
  end
end
