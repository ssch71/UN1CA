package android.content;
public abstract class ContentProvider {
 private Context context; public void attach(Context c){context=c;} public Context getContext(){return context;}
 public abstract boolean onCreate();public void shutdown(){}
 public abstract android.os.Bundle call(String m,String a,android.os.Bundle e);
 public abstract android.os.ParcelFileDescriptor openFile(android.net.Uri u,String m)throws java.io.FileNotFoundException;
 public abstract android.database.Cursor query(android.net.Uri u,String[] p,String s,String[] a,String o);
 public abstract String getType(android.net.Uri u);public abstract android.net.Uri insert(android.net.Uri u,ContentValues v);
 public abstract int delete(android.net.Uri u,String s,String[] a);public abstract int update(android.net.Uri u,ContentValues v,String s,String[] a);
}
