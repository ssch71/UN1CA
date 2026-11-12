import io.mesalabs.rezoss.memory.GesturePolicy;

public final class GesturePolicyTest {
    private static int checks;
    private static void check(boolean condition, String message) {
        checks++;
        if (!condition) throw new AssertionError(message);
    }
    public static void main(String[] args) {
        for (boolean memory : new boolean[]{false, true})
            for (boolean homeUp : new boolean[]{false, true})
                for (boolean marker : new boolean[]{false, true})
                    check(GesturePolicy.enabled(memory, homeUp, marker) == (memory && !homeUp && !marker), "priority");
        String[] directions = {"SWIPE_DOWN", "SWIPE_RIGHT", "SWIPE_LEFT", "SWIPE_UP", "PINCH_IN", "SINGLE_TAP", "DOUBLE_TAP", "LONG_TAP"};
        for (String direction : directions) {
            check(GesturePolicy.action(false, direction, false) == 0, "other finger tiers");
            check(GesturePolicy.action(true, direction, true) == 0, "continuous repeat rejected");
        }
        check(GesturePolicy.action(true, "SWIPE_DOWN", false) == GesturePolicy.SCREEN, "screen");
        check(GesturePolicy.action(true, "SWIPE_RIGHT", false) == GesturePolicy.VOICE, "voice");
        check(GesturePolicy.action(true, "SWIPE_LEFT", false) == GesturePolicy.CAMERA, "camera");
        check(GesturePolicy.action(true, "SWIPE_UP", false) == 0, "up ignored");
        check(GesturePolicy.action(true, null, false) == 0, "unknown ignored");
        GesturePolicy.Session session = new GesturePolicy.Session();
        session.begin(false);
        check(!session.owns(), "Home Up retains stream");
        check(session.claim(true, true, "SWIPE_DOWN", false) == 0, "enabling mid-stream cannot steal it");
        session.begin(true);
        check(session.owns(), "Memory owns eligible stream");
        check(session.claim(true, false, "SWIPE_DOWN", false) == 0, "two-finger event ignored");
        check(session.claim(true, true, "SWIPE_UP", false) == 0, "up ignored without firing");
        check(session.claim(true, true, "SWIPE_DOWN", false) == 1, "first recognized swipe");
        check(session.claim(true, true, "SWIPE_LEFT", false) == 0, "one launch per stream");
        session.begin(true);
        session.observe(4, false);
        session.observe(3, false);
        check(session.claim(true, true, "SWIPE_DOWN", false) == 0, "four fingers cannot become a three-finger capture");
        session.begin(true);
        session.observe(3, true);
        check(session.claim(true, true, "SWIPE_DOWN", false) == 0, "cancel suppresses capture");
        session.begin(true);
        check(session.claim(false, true, "SWIPE_DOWN", false) == 0, "disabling mid-stream stops capture");
        check(session.owns(), "cancelled Memory stream never falls through to stale Home Up action");
        session.begin(true);
        check(session.claim(true, true, "SWIPE_RIGHT", false) == 2, "next gesture resets state");
        System.out.println("PASS: " + checks + " gesture policy checks");
    }
}
