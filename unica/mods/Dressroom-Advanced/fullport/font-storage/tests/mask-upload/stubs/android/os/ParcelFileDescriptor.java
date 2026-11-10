package android.os;import java.io.*;
/** Models descriptor close notification by posting to its supplied Handler. */
public class ParcelFileDescriptor implements AutoCloseable {
 public static final int MODE_READ_ONLY=1,MODE_WRITE_ONLY=2;
 public interface OnCloseListener {void onClose(IOException error);}
 private final File file;private final Handler handler;private final OnCloseListener listener;
 private ParcelFileDescriptor(File f,Handler h,OnCloseListener l){file=f;handler=h;listener=l;}
 public static ParcelFileDescriptor open(File f,int m)throws FileNotFoundException{return new ParcelFileDescriptor(f,null,null);}
 public static ParcelFileDescriptor open(File f,int m,Handler h,OnCloseListener l)throws IOException{return new ParcelFileDescriptor(f,h,l);}
 public void bytes(byte[] b)throws IOException{try(FileOutputStream out=new FileOutputStream(file)){out.write(b);}}
 public void close(){if(listener!=null)handler.post(()->listener.onClose(null));}
}

