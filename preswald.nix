{ lib
, fetchFromGitHub
, python3
, python3Packages
, websockets_10
}:

python3.pkgs.buildPythonPackage rec {
  pname = "preswald"; 
  version = "0.1.51";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "StructuredLabs";
    repo = "preswald";
    rev = "${version}";
    sha256 = "sha256-Q8BI0YIkRFrG01yg/kroOumvTlxGcxVZtpZ5ZK6ihqY=";
  };

  nativeBuildInputs = [
    python3Packages.setuptools
    python3Packages.pip
    python3Packages.wheel
  ];

  propagatedBuildInputs = [
    python3Packages.pandas
    python3Packages.toml
    python3Packages.plotly
    python3Packages.markdown
    python3Packages.matplotlib
    python3Packages.fastapi
    python3Packages.uvicorn
    python3Packages.duckdb
    python3Packages.scipy
    python3Packages.httpx
    python3Packages.python-multipart
    python3Packages.jinja2
    python3Packages.click
    python3Packages.networkx
    python3Packages.requests
    python3Packages.tomli
    websockets_10
  ];

  meta = with lib; {
    description = "Open-source framework for building data apps, dashboards, and internal tools.";
    homepage = "https://www.preswald.com/";
    license = licenses.asl20;
    maintainers = with maintainers; [ averdow ];
  };
}
