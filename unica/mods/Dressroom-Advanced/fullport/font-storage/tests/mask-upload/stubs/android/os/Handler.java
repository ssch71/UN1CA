package android.os;public class Handler {private final Looper looper;public Handler(Looper l){looper=l;}public boolean post(Runnable task){return looper.queue.offer(task);}}
