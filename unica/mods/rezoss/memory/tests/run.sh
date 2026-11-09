#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
MEMORY_TEST_SOURCE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
MEMORY_TEST_BUILD=$(mktemp -d /tmp/rezoss-memory-policy-test.XXXXXX)
javac --release 8 -d "$MEMORY_TEST_BUILD" \
    "$MEMORY_TEST_SOURCE/java/io/mesalabs/rezoss/memory/GesturePolicy.java" \
    "$MEMORY_TEST_SOURCE/tests/GesturePolicyTest.java"
java -cp "$MEMORY_TEST_BUILD" GesturePolicyTest
python3 "$MEMORY_TEST_SOURCE/tests/test_package.py"
