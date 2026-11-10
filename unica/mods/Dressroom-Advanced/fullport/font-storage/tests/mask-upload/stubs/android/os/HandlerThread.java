package android.os;public class HandlerThread extends Thread {
 private final Looper looper=new Looper();private volatile boolean done;public HandlerThread(String n){super(n);setDaemon(true);}public Looper getLooper(){return looper;}
 public void run(){while(!done)try{looper.queue.take().run();}catch(InterruptedException e){if(done)return;}}
 public boolean quitSafely(){done=true;interrupt();return true;}}

