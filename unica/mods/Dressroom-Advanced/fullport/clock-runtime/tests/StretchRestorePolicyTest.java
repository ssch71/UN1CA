package dev.denver.dressroomadvanced;

public final class StretchRestorePolicyTest {
    private static int checks;
    private static void check(boolean value, String reason) {
        if (!value) throw new AssertionError(reason);
        checks++;
    }
    public static void main(String[] args) {
        check(StretchRestorePolicy.eligible(true, 803, 803, "", "", false), "Native stretch profile rejected");
        check(StretchRestorePolicy.eligible(true, 800, 800, "", "", false), "Samsung default native stretch capability was incorrectly denied");
        check(StretchRestorePolicy.eligible(true, 0, 0, "", "", false), "Samsung legacy default native stretch capability was incorrectly denied");
        check(!StretchRestorePolicy.eligible(false, 500, 500, "", "", false), "Depth-enabled native nonstretch font acquired stretch capability");
        check(!StretchRestorePolicy.eligible(true, 803, 804, "", "", false), "Shape leaked between font selections");
        check(!StretchRestorePolicy.eligible(true, 803, 803, "old.ttf", "new.ttf", false), "Shape leaked between font files");
        check(!StretchRestorePolicy.eligible(true, 803, 803, "", "", true), "Display/imported font acquired Samsung stretch shape");
        check(!StretchRestorePolicy.eligible(false, 700, 700, "unica_font:test", "unica_font:test", false), "UN1CA static font acquired stretch capability");
        check(!StretchRestorePolicy.eligible(true, 803, -1, "", "", false), "Unscoped legacy profile restored shape");
        System.out.println("Stretch restore policy: " + checks + " checks passed");
    }
}
