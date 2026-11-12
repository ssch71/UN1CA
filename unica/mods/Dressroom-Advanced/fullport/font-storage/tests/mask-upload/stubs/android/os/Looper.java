package android.os;import java.util.concurrent.*;
public class Looper {static final Looper MAIN=new Looper();final BlockingQueue<Runnable> queue=new LinkedBlockingQueue<>();public static Looper getMainLooper(){return MAIN;}}

