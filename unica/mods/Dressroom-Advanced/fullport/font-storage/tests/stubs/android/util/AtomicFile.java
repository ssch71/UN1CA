package android.util;
import java.io.*;
import java.nio.file.*;
/** Host filesystem double; these tests do not establish Android AtomicFile crash guarantees. */
public class AtomicFile {
 private final File base,temp;
 public AtomicFile(File base){this.base=base;temp=new File(base+".new");}
 public FileInputStream openRead()throws FileNotFoundException{return new FileInputStream(base);}
 public FileOutputStream startWrite()throws IOException{return new FileOutputStream(temp);}
 public void finishWrite(FileOutputStream out){try{out.close();Files.move(temp.toPath(),base.toPath(),StandardCopyOption.REPLACE_EXISTING,StandardCopyOption.ATOMIC_MOVE);}catch(IOException e){throw new IllegalStateException(e);}}
 public void failWrite(FileOutputStream out){try{out.close();Files.deleteIfExists(temp.toPath());}catch(IOException e){throw new IllegalStateException(e);}}
}
