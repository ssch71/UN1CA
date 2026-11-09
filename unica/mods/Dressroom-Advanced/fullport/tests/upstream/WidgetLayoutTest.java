package dev.denver.dressroomadvanced;

public final class WidgetLayoutTest {
    private static int checks;

    private static void check(boolean value, String message) {
        checks++;
        if (!value) throw new AssertionError(message);
    }

    public static void main(String[] args) {
        int[][] items = {{1, 1}, {1, 1}, {2, 2}};
        check(WidgetLayout.fits(4, 2, items), "A supported 2-row widget should fit");
        check(!WidgetLayout.fits(4, 1, items), "Shrinking must reject a 2-row widget");
        check(!WidgetLayout.fits(1, 4, items), "Vertical grid cannot hold a 2-column widget");
        check(
                WidgetLayout.fits(1, 4, new int[][] {{1, 1}, {1, 1}, {1, 2}}),
                "Vertical packing failed");
        check(WidgetLayout.fits(4, 1, new int[0][2]), "Empty grid failed");
        check(!WidgetLayout.fits(8, 8, new int[0][2]), "Oversized grid accepted");
        check(!WidgetLayout.fits(4, 2, new int[][] {{0, 1}}), "Malformed provider span accepted");
        check(items[0][0] == 1 && items[2][0] == 2, "Fit check changed provider ordering");
        check(
                WidgetLayout.positionsValid(
                        4, 2, new int[][] {{0, 0, 2, 1}, {2, 0, 2, 2}, {0, 1, 2, 1}}),
                "Valid mixed-size grid was marked for repair");
        check(
                !WidgetLayout.positionsValid(4, 2, new int[][] {{0, 0, 2, 1}, {0, 0, 2, 2}}),
                "Overlapping widgets were accepted");
        check(
                !WidgetLayout.positionsValid(2, 4, new int[][] {{0, 0, 2, 2}, {1, 2, 2, 1}}),
                "A horizontal coordinate survived outside the vertical grid");
        check(
                WidgetLayout.positionsValid(
                        2, 4, new int[][] {{0, 0, 2, 2}, {0, 2, 2, 1}, {0, 3, 2, 1}}),
                "Valid vertical secondary positions were rejected");
        check(
                !WidgetLayout.positionsValid(4, 2, new int[][] {{-1, 0, 1, 1}}),
                "An unplaced widget was accepted");
        check(
                !WidgetLayout.positionsValid(4, 2, new int[][] {{Integer.MAX_VALUE, 0, 2, 1}}),
                "Overflowed coordinates bypassed grid bounds");
        int[] projected = WidgetLayout.dimensions(4, 2, false, true);
        check(
                projected[0] == 2 && projected[1] == 4,
                "Native vertical layout did not transpose capacity");
        int[] unchanged = WidgetLayout.dimensions(2, 4, true, true);
        check(unchanged[0] == 2 && unchanged[1] == 4, "Native vertical capacity transposed twice");
        check(
                !WidgetLayout.matchesOrientation(4, 2, true),
                "Vertical control disagrees with Samsung position type");
        check(
                WidgetLayout.matchesOrientation(2, 4, true),
                "Tall grid should use secondary native positions");
        check(
                WidgetLayout.matchesOrientation(2, 2, false)
                        && !WidgetLayout.matchesOrientation(2, 2, true),
                "Square grids must use native Default positions");
        float[] below =
                WidgetLayout.place(1, 200, 300, 600, 500, 200, 100, 1000, 2000, 10, .5f, .5f);
        check(below[0] == 300 && below[1] == 510, "Below docking failed");
        float[] above =
                WidgetLayout.place(2, 200, 300, 600, 500, 200, 100, 1000, 2000, 10, .5f, .5f);
        check(above[0] == 300 && above[1] == 190, "Above docking failed");
        float[] left =
                WidgetLayout.place(3, 200, 300, 600, 500, 100, 100, 1000, 2000, 10, .5f, .5f);
        check(left[0] == 90 && left[1] == 350, "Left docking failed");
        float[] right =
                WidgetLayout.place(4, 200, 300, 600, 500, 100, 100, 1000, 2000, 10, .5f, .5f);
        check(right[0] == 610 && right[1] == 350, "Right docking failed");
        float[] slidRight =
                WidgetLayout.place(4, 200, 300, 600, 500, 100, 100, 1000, 2000, 10, .5f, .5f, 70);
        check(
                slidRight[0] == 610 && slidRight[1] == 420,
                "A snapped right grid must slide vertically without detaching");
        float[] slidAbove =
                WidgetLayout.place(2, 200, 300, 600, 500, 100, 100, 1000, 2000, 10, .5f, .5f, -80);
        check(
                slidAbove[0] == 270 && slidAbove[1] == 190,
                "An above-clock grid must slide horizontally without changing its gap");
        float[] extreme =
                WidgetLayout.place(3, 200, 300, 600, 500, 100, 100, 1000, 2000, 10, .5f, .5f, 5000);
        check(
                extreme[0] == 90 && extreme[1] == 1900,
                "Sliding a snapped grid escaped screen bounds");
        float[] zero = WidgetLayout.place(5, 200, 300, 600, 500, 200, 100, 1000, 2000, 10, 0, 0);
        check(zero[0] == 0 && zero[1] == 0, "Free origin was treated as a sentinel");
        float[] edge = WidgetLayout.place(5, 200, 300, 600, 500, 200, 100, 1000, 2000, 10, 1, 1);
        check(edge[0] == 800 && edge[1] == 1900, "Free edge escapes screen");
        float[] oversized = WidgetLayout.place(5, 0, 0, 0, 0, 2000, 3000, 1000, 2000, 0, 1, 1);
        check(oversized[0] == 0 && oversized[1] == 0, "Oversized grid produced negative position");
        check(WidgetLayout.finite(Float.NaN, 1, .5f, 2) == 1, "NaN reached native metrics");
        check(WidgetLayout.effectiveAnchor(0, true, true, true) == 4, "Fold8 default vertical must dock right");
        check(WidgetLayout.effectiveAnchor(0, true, false, true) == 0, "Horizontal native placement changed");
        check(WidgetLayout.effectiveAnchor(5, true, true, true) == 5, "Free placement changed");
        check(WidgetLayout.effectiveAnchor(0, true, true, false) == 0, "Existing providers changed");
        check(WidgetLayout.effectiveAnchor(0, false, true, true) == 0, "Stock non-custom layout changed");
        System.out.println("Widget layout contracts: " + checks + " checks passed");
    }
}
