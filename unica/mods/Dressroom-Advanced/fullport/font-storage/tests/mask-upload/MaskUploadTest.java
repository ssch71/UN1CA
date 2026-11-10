package dev.denver.dressroomadvanced;
import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;
import java.nio.file.*;
import java.util.*;
/** Exercises production SettingsProvider with queued close events and a blocked UI loop. */
public final class MaskUploadTest {
 private static int checks;
 private static void check(boolean okay,String message){if(!okay)throw new AssertionError(message);checks++;}
 private static String key(byte[] bytes)throws Exception{return DepthStorage.hex(java.security.MessageDigest.getInstance("SHA-256").digest(bytes));}
 private static Bundle profile(String key){Bundle b=new Bundle();b.putString("depthMaskRef",key);return b;}
 private static void upload(SettingsProvider provider,String hash,byte[] bytes)throws Exception {
  try(ParcelFileDescriptor fd=provider.openFile(DepthStorage.uri(hash),"w")){fd.bytes(bytes);}
 }
 private static void rejected(SettingsProvider provider,Bundle profile,String expected){
  try{provider.call("commit",null,profile);throw new AssertionError("Expected mask rejection");}
  catch(IllegalStateException error){check(error.getMessage().contains(expected),"Correct mask rejection: "+error.getMessage());}
 }
 public static void main(String[] args)throws Exception {
  Path root=Files.createTempDirectory("dra-mask-upload-");
  SettingsProvider provider=new SettingsProvider();provider.attach(new Context(root.toFile()));provider.onCreate();
  try {
   byte[] valid=new byte[96*1024];new Random(31).nextBytes(valid);String hash=key(valid);
   long started=System.nanoTime();upload(provider,hash,valid);
   Bundle result=provider.call("commit",null,profile(hash));
   check(result.getBoolean("saved"),"Main-thread synchronous Apply completes without draining main queue");
   check((System.nanoTime()-started)/1000000<2000,"No main-loop 3-second publication timeout");
   Path published=root.resolve("depth-masks").resolve(hash);
   check(Arrays.equals(valid,Files.readAllBytes(published)),"Published bytes exactly match hash input");
   // Corrupt data cannot become an immutable content-addressed blob.
   byte[] broken=valid.clone();broken[0]^=0x7f;String wrong=key(new byte[]{3,4,5});
   upload(provider,wrong,broken);rejected(provider,profile(wrong),"Invalid mask checksum");
   check(!Files.exists(root.resolve("depth-masks").resolve(wrong)),"Checksum-rejected file is never published");
   // A failed attempt is retryable: reopening clears its prior rejection.
   byte[] retryBytes=new byte[]{3,4,5};upload(provider,wrong,retryBytes);
   check(provider.call("commit",null,profile(wrong)).getBoolean("saved"),"Retry after checksum failure succeeds");
   byte[] empty=new byte[0];String emptyKey=key(empty);upload(provider,emptyKey,empty);rejected(provider,profile(emptyKey),"Invalid subject mask size");
   byte[] huge=new byte[16*1024*1024+1];String hugeKey=key(huge);upload(provider,hugeKey,huge);rejected(provider,profile(hugeKey),"Invalid subject mask size");
   // Batch Apply must wait for every independently uploaded depth blob.
   byte[] second=new byte[]{9,10};String secondKey=key(second);upload(provider,secondKey,second);
   Bundle first=profile(hash);first.putString("depthSourceMaskRef",secondKey);
   Bundle operation=new Bundle();operation.putBundle("profile",first);
   Bundle batch=new Bundle();ArrayList<Bundle> operations=new ArrayList<>();operations.add(operation);batch.putParcelableArrayList("operations",operations);
   check(provider.call("commitBatch",null,batch).getBoolean("saved"),"Batch Apply waits for both published blobs");
   try{provider.openFile(Uri.parse("content://io.mesalabs.unica.dressroomadvanced.settings/masks/not-a-hash"),"w");throw new AssertionError("Bad mask ID accepted");}
   catch(java.io.FileNotFoundException expected){checks++;}
   try(java.util.stream.Stream<Path> files=Files.list(root.resolve("depth-masks"))){check(files.noneMatch(p->p.getFileName().toString().startsWith("upload-")),"Temporary uploads cleaned after success and rejection");}
   System.out.println("Mask upload regression: "+checks+" checks passed; production provider, simulated Android close dispatch");
  }finally{provider.shutdown();}
 }
}
