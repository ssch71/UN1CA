package dev.denver.dressroomadvanced;

import java.util.concurrent.atomic.AtomicBoolean;

public final class CaptureInstanceStateTest {
    private static int checks;
    private static final AtomicBoolean ready = new AtomicBoolean();
    private static long handles;
    private static final class Engine {
        long handle;
        int allocations, releases;
        void init() {
            if (ready.get()) return;
            handle = ++handles;
            allocations++;
            ready.set(true);
        }
        void release() {
            if (ready.getAndSet(false)) { handle = 0; releases++; }
        }
    }
    private static void check(boolean value, String message) {
        if (!value) throw new AssertionError(message);
        checks++;
    }
    private static void init(CaptureInstanceState<Engine> state, Engine engine) {
        state.prepare(engine);
        try { engine.init(); state.opened(engine); }
        finally { state.restore(); }
    }
    private static void release(CaptureInstanceState<Engine> state, Engine engine) {
        state.prepare(engine);
        try { engine.release(); }
        finally { state.closed(engine); state.restore(); }
    }
    public static void main(String[] args) {
        var state = new CaptureInstanceState<Engine>(ready, engine -> engine.handle);
        Engine first = new Engine(), second = new Engine();
        init(state, first);
        check(first.handle != 0 && ready.get(), "First engine not initialized");
        init(state, second);
        check(second.handle != 0 && second.handle != first.handle,
                "Class-wide ready flag skipped the second native engine");
        init(state, second);
        check(second.allocations == 1, "Capture reinitialized an existing engine");
        release(state, first);
        check(first.handle == 0 && first.releases == 1, "Live peer prevented engine release");
        check(ready.get() && second.handle != 0, "Releasing one instance invalidated its peer");
        release(state, first);
        check(first.releases == 1, "Uninitialized instance released twice");
        check(ready.get(), "Duplicate release cleared a live peer's ready state");
        Engine failed = new Engine();
        state.prepare(failed);
        check(!ready.get(), "Failed/new instance inherited another engine's ready flag");
        state.restore();
        check(ready.get(), "Failed initialization stranded the existing engine");
        try { state.opened(failed); throw new AssertionError("Zero native handle accepted"); }
        catch (IllegalStateException expected) { checks++; }
        release(state, second);
        check(!ready.get() && second.handle == 0, "Final release retained ready state");
        Engine earlier = new Engine();
        earlier.handle = 99;
        ready.set(true);
        init(state, earlier);
        check(earlier.allocations == 0, "Engine initialized before hooks loaded was replaced");
        release(state, earlier);
        check(earlier.releases == 1 && !ready.get(), "Earlier native engine leaked");
        System.out.println("Per-instance native capture lifecycle: " + checks + " checks passed");
    }
}
