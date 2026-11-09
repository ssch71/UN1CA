package dev.denver.dressroomadvanced;

public final class DepthSourcePolicyTest {
    private static int checks;

    private static void check(boolean value, String reason) {
        if (!value) throw new AssertionError(reason);
        checks++;
    }

    public static void main(String[] args) {
        check(DepthSourcePolicy.visible(true, false), "Awake wallpaper requires the AOD switch");
        check(DepthSourcePolicy.visible(false, true), "Full-screen AOD loses its subject");
        check(!DepthSourcePolicy.visible(false, false), "Black AOD keeps a subject cut");
        DepthSourcePolicy state = new DepthSourcePolicy();
        check(!state.observe("photo-a"), "Initial source treated as replacement");
        check(!state.observe("photo-a"), "Same image reset depth");
        check(state.observe("photo-b"), "Replacement image retained depth");
        check(!state.observe("photo-b"), "Repeated source notification reset depth");
        state.reset();
        check(!state.observe("photo-b"), "New editor retained old source identity");
        for (int type : new int[] {0, 19, 23, 401, 402, 408})
            check(DepthSourcePolicy.image(type, 0), "Still-image effect rejected: " + type);
        for (int type : new int[] {1, 3, 5, 7, 8, 9, 15, 202, 403, 999})
            check(!DepthSourcePolicy.image(type, 0), "Unsupported renderer accepted: " + type);
        check(!DepthSourcePolicy.image(0, 8), "Video parent accepted through image child");
        check(
                DepthSourcePolicy.image(402, 401),
                "Weather/frame wrapping changed source eligibility");
        check(
                DepthSourcePolicy.invalidProfile(true, true, false, "new", "old"),
                "Old wallpaper profile accepted");
        check(
                !DepthSourcePolicy.invalidProfile(true, true, true, "new", "new"),
                "Fresh current-image profile rejected by the earlier reset");
        check(
                DepthSourcePolicy.invalidProfile(true, true, true, "new", ""),
                "Unstamped legacy matte accepted after replacement");
        check(
                DepthSourcePolicy.invalidProfile(true, false, false, "new", "new"),
                "A matching key bypassed unsupported wallpaper protection");
        check(
                !DepthSourcePolicy.invalidProfile(false, false, false, "", "old"),
                "Unknown source treated as a confirmed replacement");
        check(
                DepthSourcePolicy.invalidProfile(true, true, true, "new", "old"),
                "Reading a stale profile cleared replacement protection");
        check(
                !DepthSourcePolicy.invalidProfile(true, true, true, "new", "new"),
                "Reading a stale profile poisoned the next current profile");
        System.out.println("Depth source policy: " + checks + " checks passed");
    }
}
