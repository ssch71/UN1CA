package dev.denver.dressroomadvanced;
class NativeSettings {static final android.net.Uri URI=android.net.Uri.parse("content://io.mesalabs.unica.dressroomadvanced.settings");}
class NativeProfileStore {NativeProfileStore(android.content.Context c){}android.os.Bundle read(String s,android.os.Bundle b){return new android.os.Bundle();}android.os.Bundle commit(String s,android.os.Bundle b){return saved();}android.os.Bundle commitBatch(java.util.ArrayList<android.os.Bundle> b){return saved();}static android.os.Bundle saved(){android.os.Bundle b=new android.os.Bundle();b.putBoolean("saved",true);return b;}}
class FontFiles {static android.os.Bundle begin(android.content.Context c){return null;}static android.os.Bundle result(android.content.Context c,String a){return null;}static java.io.File file(android.content.Context c,String i){return null;}}
class DepthMetadata {static final String[] BLOBS={"depthMask","depthSourceMask"};}
class DepthStorage {static android.net.Uri uri(String k){if(!k.matches("[0-9a-f]{64}"))throw new IllegalArgumentException("bad hash");return android.net.Uri.parse("content://io.mesalabs.unica.dressroomadvanced.settings/masks/"+k);}static String hex(byte[] bytes){StringBuilder b=new StringBuilder();for(byte v:bytes)b.append(String.format("%02x",v&255));return b.toString();}}
class DressroomModule {static final String TAG="DressroomAdvanced";}

