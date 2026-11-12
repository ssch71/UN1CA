package android.content;
public class Context {private final java.io.File files;private final ContentResolver resolver=new ContentResolver();public Context(java.io.File f){files=f;}public java.io.File getFilesDir(){return files;}public android.content.pm.PackageManager getPackageManager(){return new android.content.pm.PackageManager();}public ContentResolver getContentResolver(){return resolver;}}

