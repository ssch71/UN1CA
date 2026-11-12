package dev.denver.dressroomadvanced;

import java.util.ArrayList;

public final class LatestDepthWorkTest {
    private static int checks;

    private static void check(boolean value) {
        if (!value) throw new AssertionError("Mailbox check " + checks);
        checks++;
    }

    public static void main(String[] args) {
        ArrayList<Integer> started = new ArrayList<>();
        ArrayList<Runnable> finished = new ArrayList<>();
        LatestDepthWork<Integer> work =
                new LatestDepthWork<>(
                        (value, complete) -> {
                            started.add(value);
                            finished.add(complete);
                        });
        work.offer(0);
        check(started.equals(java.util.List.of(0)));
        for (int i = 1; i <= 1000; i++) work.offer(i);
        check(started.size() == 1);
        finished.get(0).run();
        check(started.equals(java.util.List.of(0, 1000)));
        finished.get(0).run();
        check(started.size() == 2);
        work.offer(1001);
        work.clear();
        finished.get(1).run();
        check(started.size() == 2);
        work.offer(1002);
        check(started.get(2) == 1002);
        work.clear();
        work.offer(1003);
        check(started.size() == 3);
        finished.get(2).run();
        check(started.get(3) == 1003);
        finished.get(3).run();
        work.offer(1004);
        check(started.get(4) == 1004);
        final boolean[] fail = {true};
        final int[] calls = {0};
        LatestDepthWork<Integer> recovering =
                new LatestDepthWork<>(
                        (value, complete) -> {
                            calls[0]++;
                            if (fail[0]) throw new IllegalStateException("Test");
                            complete.run();
                            complete.run();
                        });
        try {
            recovering.offer(1);
            throw new AssertionError("Expected failure");
        } catch (IllegalStateException expected) {
            checks++;
        }
        fail[0] = false;
        recovering.offer(2);
        recovering.offer(3);
        check(calls[0] == 3);
        System.out.println("Bounded depth work: " + checks + " checks passed");
    }
}
