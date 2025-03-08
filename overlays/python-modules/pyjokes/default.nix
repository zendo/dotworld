{
  lib,
  buildPythonPackage,
  fetchPypi,
  pytest,
}:

buildPythonPackage rec {
  pname = "pyjokes";
  version = "0.6.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-CIYO7beMv6RhgkPI2wiPIcOYI+zh/a8BM+UtnFbpgaU=";
  };

  pythonImportsCheck = [ "pyjokes" ];

  meta = with lib; {
    description = "One line jokes for programmers (jokes as a service)";
    homepage = "https://pyjok.es/";
    license = licenses.bsd3;
  };
}
