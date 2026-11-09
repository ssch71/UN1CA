package dev.denver.dressroomadvanced;

public final class BlurOpacityTest {
    private static int checks;

    private static void check(float value, float expected) {
        if (Math.abs(value - expected) > .00001f)
            throw new AssertionError(value + " != " + expected);
        checks++;
    }

    public static void main(String[] args) {
        check(BlurOpacity.resolve(-1, true, true, 0xffff0000, 50, 1), .5f);
        check(BlurOpacity.resolve(-1, true, true, 0xff00ff00, 90, 1), .35f);
        check(BlurOpacity.resolve(-1, true, true, 0x800000ff, 50, .502f), .502f);
        check(BlurOpacity.resolve(-1, false, true, 0xffffffff, 50, 1), 1);
        check(BlurOpacity.resolve(-1, true, false, 0xffffffff, 50, .35f), .35f);
        check(BlurOpacity.resolve(.8f, true, true, 0xffffffff, 50, 1), .8f);
        check(BlurOpacity.resolve(0, true, true, 0xffffffff, 50, 1), 0);
        check(BlurOpacity.resolve(2, true, true, 0xffffffff, 50, 1), 1);
        check(BlurOpacity.resolve(-1, true, true, 0xffffffff, Double.NaN, 1), 1);
        System.out.println("Clock blur opacity: " + checks + " checks passed");
    }
}
