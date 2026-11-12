// SPDX-License-Identifier: GPL-3.0-or-later
import io.mesalabs.rezoss.memory.SideKeyPolicy;

public class SideKeyPolicyTest {
    private static int checks;
    private static void check(int expected, int actual) {
        checks++;
        if (expected != actual) throw new AssertionError(expected + " != " + actual);
    }
    public static void main(String[] args) {
        SideKeyPolicy policy = new SideKeyPolicy();
        check(0, policy.event(2, true)); // Cleanup without a matching start.
        check(0, policy.event(99, true));
        check(2, policy.event(1, true));
        check(1, policy.event(1, true)); // Duplicate start cannot record twice.
        check(1, policy.event(1, false)); // Ownership persists across disabling.
        check(1, policy.event(2, false)); // Consume native cancellation cleanup.
        check(0, policy.event(2, true));
        check(0, policy.event(1, false)); // Accessibility/locked/absent app: stock.
        check(0, policy.event(1, true)); // Enabling mid-chord cannot steal stock.
        check(0, policy.event(2, true));
        check(2, policy.event(1, true)); // Next chord may use Memory again.
        check(1, policy.event(2, true));
        // Long holds/repeat callbacks never produce extra launches; each chord
        // clears its state even if eligibility changes before release.
        for (int chord = 0; chord < 100; chord++) {
            boolean enabled = (chord % 2 == 0);
            check(enabled ? 2 : 0, policy.event(1, enabled));
            for (int repeat = 0; repeat < 10; repeat++) {
                check(enabled ? 1 : 0, policy.event(1, repeat % 2 == 0));
            }
            check(enabled ? 1 : 0, policy.event(2, !enabled));
        }
        System.out.println("PASS: " + checks + " side-key ownership/repeat/cancellation checks");
    }
}
