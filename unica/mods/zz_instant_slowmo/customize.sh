# Instant Slow-mo on z3q. The donor asks the vendor MPP for AI FRC (type 7), which SM8250 does
# not have (the aifrc.dlc only carries an HTP v73 cache). The vendor ships a 2x FRUC (type 3,
# OpenCL on Adreno 650) behind an mpp V1 AIDL server, so libaplayer is pointed at that instead
# and libmppclient is taught to live with the V1 server.

# This lives in unica/mods (sorted last) rather than target/z3q/patches because the mods replace
# both system libraries afterwards: paradigm installs the S26U libaplayer and rezoss the S26U
# libmppclient. Patching the donor copies earlier left the shipped ROM with unpatched libraries.
if [[ "$TARGET_PLATFORM" != "sm8250" ]]; then
    LOG "- Skipping Instant Slow-mo: sm8250 only"
    return 0
fi

# _MASKED_PATCH <file> <from> <to>
# Like HEX_PATCH, but "??" in <from> matches any byte (used for PC-relative bl/adrp operands,
# which move whenever the donor library is rebuilt) and "??" in <to> keeps the original byte.
# Aborts unless <from> matches exactly once.
_MASKED_PATCH()
{
    local OUT
    if ! OUT="$(python3 - "$1" "$2" "$3" <<'PY'
import re, sys
f, a, b = sys.argv[1:4]
a = a.replace(" ", "").lower(); b = b.replace(" ", "").lower()
if len(a) != len(b):
    sys.exit("pattern lengths differ")
d = bytearray(open(f, "rb").read())
rx = b"".join(b"." if a[i:i+2] == "??" else re.escape(bytes.fromhex(a[i:i+2])) for i in range(0, len(a), 2))
m = [x.start() for x in re.finditer(rx, d, re.S)]
if len(m) != 1:
    sys.exit("%d matches" % len(m))
for i in range(0, len(b), 2):
    if b[i:i+2] != "??":
        d[m[0] + i // 2] = int(b[i:i+2], 16)
open(f, "wb").write(d)
print("0x%x" % m[0])
PY
)"; then
        ABORT "! ${1//$WORK_DIR/}: \"$2\" - $OUT"
    fi
    LOG "- Patched ${1//$WORK_DIR/} at $OUT"
}

_LIB="$WORK_DIR/system/system/lib64"

LOG_STEP_IN "- libaplayer: AI FRC -> vendor FRC"
# isAiFrcSupported(): IsSupported(7) -> IsSupported(3)
_MASKED_PATCH "$_LIB/libaplayer.so" "e1230091e0008052a1" "e123009160008052a1"
# createPostGenerator(): MppGenerator::Type AIFRC(4) -> FRC(2)
_MASKED_PATCH "$_LIB/libaplayer.so" "750200f99500805280" "750200f95500805280"
# isColorFormatRequired(): always request a decoder colour format (no UBWC into the V1 MPP)
_MASKED_PATCH "$_LIB/libaplayer.so" "e00313aae10314aa????????c0000034" "????????????????????????06000014"
# setupVideo(): no useInputSurface (queueInput does not exist in mpp V1)
_MASKED_PATCH "$_LIB/libaplayer.so" "1f051b720008005458020036" "????????????????12000014"
# APlayerWrapper::setVideoFrc(): (4, 0.25) -> (2, 0.5), the FRUC only interpolates 2x
_MASKED_PATCH "$_LIB/libaplayer.so" "3f0008eb810300540041201ea2020012e103142a" "????????1c000014????????????????????????"
_MASKED_PATCH "$_LIB/libaplayer.so" \
    "c0008052e303142a????????b4048012ebffff1768408cd2e00700f9c848aef26844dff2e850f8f2e00308aa" \
    "????????????????????????????????????????9f120071490080523401941a01102c1e280c281ee0ffff17"
LOG_STEP_OUT

LOG_STEP_IN "- libmppclient: tolerate the mpp V1 server"
# BufferFlowControl::updateBufferParam(): calcBufferElevation is V5-only, keep the init value
_MASKED_PATCH "$_LIB/libmppclient.so" "a00000341500b05206000014" "a0000034f5031f2a06000014"
LOG_STEP_OUT

LOG_STEP_IN "- vendor libmppfrc: allow 4K input"
# FRCFactory::getMppCapability(): 1920x1088 -> 3840x2176 (4K30 verified on device)
_MASKED_PATCH "$WORK_DIR/vendor/lib64/libmppfrc.so" "0100000080070000400400006f77" "01000000000f0000800800006f77"
LOG_STEP_OUT

unset _LIB
unset -f _MASKED_PATCH
