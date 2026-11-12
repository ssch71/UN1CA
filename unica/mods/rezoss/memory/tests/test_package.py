#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
from pathlib import Path
import importlib.util
import sys
import tempfile
import zipfile
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location("memory_package", Path(__file__).resolve().parents[1] / "package-dex.py")
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
with tempfile.TemporaryDirectory(prefix="rezoss-memory-package-test-") as directory:
    root = Path(directory)
    source, output = root / "original.apk", root / "patched.apk"
    dex3, dex6 = root / "classes3.dex", root / "classes6.dex"
    dex3.write_bytes(b"dex\n035\0" + b"3" * 104)
    dex6.write_bytes(b"dex\n035\0" + b"6" * 104)
    entries = {"AndroidManifest.xml": b"manifest", "resources.arsc": b"resource-table",
               "res/--6.xml": b"sparse-name", "assets/model.dat": b"asset",
               "lib/arm64-v8a/libtest.so": b"native", "classes.dex": b"unchanged-dex",
               "classes3.dex": b"old-dex", "META-INF/CERT.RSA": b"old-signature",
               "META-INF/other.properties": b"retain"}
    with zipfile.ZipFile(source, "w") as archive:
        for name, data in entries.items():
            archive.writestr(name, data)
    module.package(source, dex3, dex6, output)
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert "META-INF/CERT.RSA" not in archive.namelist()
        for name, data in entries.items():
            if name not in ("classes3.dex", "META-INF/CERT.RSA"):
                assert archive.read(name) == data, name
        assert archive.read("classes3.dex") == dex3.read_bytes()
        assert archive.read("classes6.dex") == dex6.read_bytes()
    try:
        module.package(source, dex3, dex6, output)
        raise AssertionError("existing output was overwritten")
    except ValueError:
        pass
print("PASS: original-container packaging, signature stripping and overwrite guard")
