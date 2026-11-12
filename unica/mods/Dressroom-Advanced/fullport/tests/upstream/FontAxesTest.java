package dev.denver.dressroomadvanced;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.util.List;

public final class FontAxesTest {
    private static int checks;
    private static void check(boolean value, String message) {
        if (!value) throw new AssertionError(message);
        checks++;
    }

    private static byte[] font(String... tags) {
        ByteBuffer b = ByteBuffer.allocate(44 + 16 + tags.length * 20 + 64).order(ByteOrder.BIG_ENDIAN);
        b.putInt(0, 0x00010000); b.putShort(4, (short) 2);
        b.putInt(12, 0x66766172); b.putInt(20, 44); b.putInt(24, 16 + tags.length * 20);
        int names = 44 + 16 + tags.length * 20;
        b.putInt(28, 0x6e616d65); b.putInt(36, names); b.putInt(40, 64);
        b.putShort(44, (short) 1); b.putShort(48, (short) 16);
        b.putShort(52, (short) tags.length); b.putShort(54, (short) 20);
        for (int i = 0; i < tags.length; i++) {
            int p = 60 + i * 20;
            for (int j = 0; j < 4; j++) b.put(p + j, (byte) tags[i].charAt(j));
            b.putInt(p + 4, -10 * 65536); b.putInt(p + 8, 2 * 65536); b.putInt(p + 12, 100 * 65536);
            b.putShort(p + 18, (short) 256);
        }
        byte[] label = "Custom axis".getBytes(StandardCharsets.UTF_16BE);
        b.putShort(names + 2, (short) 1); b.putShort(names + 4, (short) 18);
        b.putShort(names + 6, (short) 3); b.putShort(names + 8, (short) 1);
        b.putShort(names + 10, (short) 0x409); b.putShort(names + 12, (short) 256);
        b.putShort(names + 14, (short) label.length);
        b.position(names + 18); b.put(label);
        return b.array();
    }

    public static void main(String[] args) {
        List<FontAxes.Axis> axes = FontAxes.parse(font("wght", "wdth", "opsz", "slnt", "ital", "GRAD", "TEST"));
        check(axes.size() == 7, "Lost variable axes");
        check(axes.get(0).label().equals("Weight"), "Standard axis name");
        check(axes.get(2).label().equals("Optical size"), "Optical size name");
        check(axes.get(6).label().equals("Custom axis (TEST)"), "Custom name table label");
        check(axes.get(3).min() == -10 && axes.get(3).defaultValue() == 2, "Signed fixed-point metadata");
        check(axes.get(0).clamp(999) == 100 && axes.get(0).clamp(-999) == -10, "Axis clamping");
        byte[] hidden = font("TEST");
        ByteBuffer.wrap(hidden).putShort(76, (short) 1);
        check(FontAxes.parse(hidden).get(0).hidden(), "Hidden axis flag");
        check(FontAxes.parse(font("wght", "wght")).isEmpty(), "Duplicate tags accepted");
        byte[] bad = font("wght");
        ByteBuffer.wrap(bad).putInt(64, 200 * 65536);
        check(FontAxes.parse(bad).isEmpty(), "Invalid axis range accepted");
        bad = font("wght"); ByteBuffer.wrap(bad).putShort(54, (short) 19);
        check(FontAxes.parse(bad).isEmpty(), "Short axis record accepted");
        bad = font("wght"); ByteBuffer.wrap(bad).putInt(20, Integer.MAX_VALUE);
        check(FontAxes.parse(bad).isEmpty(), "Overflowing table accepted");
        byte[] valid = font("wght");
        for (int length = 0; length < 80; length++)
            check(FontAxes.parse(java.util.Arrays.copyOf(valid, length)).isEmpty(), "Truncated font accepted");
        check(!FontAxes.validTag("abc") && !FontAxes.validTag("a'b "), "Invalid API tag accepted");
        check(FontAxes.parse(null).isEmpty(), "Null font accepted");
        byte[] collection = new byte[valid.length + 16];
        ByteBuffer c = ByteBuffer.wrap(collection);
        c.putInt(0, 0x74746366); c.putInt(4, 0x00010000); c.putInt(8, 1); c.putInt(12, 16);
        System.arraycopy(valid, 0, collection, 16, valid.length);
        c.putInt(36, 60); c.putInt(52, 96);
        check(FontAxes.parse(collection).size() == 1, "TTC face-zero offsets");
        try { axes.clear(); throw new AssertionError("Mutable axis metadata"); }
        catch (UnsupportedOperationException expected) { checks++; }
        System.out.println("Font axis metadata: " + checks + " checks passed");
    }
}
