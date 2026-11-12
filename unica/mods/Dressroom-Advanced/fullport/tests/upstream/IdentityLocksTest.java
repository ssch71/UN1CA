package dev.denver.dressroomadvanced;

import java.util.List;

public final class IdentityLocksTest {
    static final class MutableKey {
        int value;

        @Override
        public int hashCode() {
            return value;
        }

        @Override
        public boolean equals(Object other) {
            return other instanceof MutableKey && ((MutableKey) other).value == value;
        }
    }

    public static void main(String[] args) {
        IdentityLocks locks = new IdentityLocks();
        MutableKey first = new MutableKey(), equalButDifferent = new MutableKey();
        locks.put(first, List.of(12f, 20f));
        require(locks.get(equalButDifferent) == null, "equal data instances must not share a hold");
        first.value = 50;
        require(locks.get(first).equals(List.of(12f, 20f)), "mutable hash must not lose the hold");
        List<Float> copy = locks.get(first);
        copy.set(0, 999f);
        require(locks.get(first).get(0) == 12f, "returned data must be defensive");
        locks.put(first, List.of(33f));
        require(locks.get(first).equals(List.of(33f)), "replacement must be unique");
        locks.remove(first);
        require(locks.get(first) == null, "automatic mode must remove hold");
        locks.put(first, List.of(1f));
        locks.clear();
        require(locks.get(first) == null, "font/style invalidation must clear hold");
        System.out.println("Identity stretch holds: 6 checks passed");
    }

    static void require(boolean condition, String message) {
        if (!condition) throw new AssertionError(message);
    }
}
