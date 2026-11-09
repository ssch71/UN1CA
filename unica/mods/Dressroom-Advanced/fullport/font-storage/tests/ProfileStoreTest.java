package dev.denver.dressroomadvanced;
import android.content.Context;
import android.os.Bundle;
import java.nio.file.*;
import java.util.*;
public final class ProfileStoreTest {
 static int checks;
 static void check(boolean value,String reason){if(!value)throw new AssertionError(reason);checks++;}
 static Bundle identity(int wallpaper,int font){Bundle b=new Bundle();b.putInt("wallpaperId",wallpaper);b.putInt("type",1);b.putInt("font",font);b.putInt("layoutOrientation",1);return b;}
 static void expectFailure(Runnable work){try{work.run();throw new AssertionError("Expected rejected operation");}catch(IllegalArgumentException|IllegalStateException expected){checks++;}}
 public static void main(String[] args)throws Exception {
  Path directory=Files.createTempDirectory("dra-profiles-");Context context=new Context(directory.toFile());
  NativeProfileStore store=new NativeProfileStore(context);Bundle query=identity(100,700);
  check(store.read("clock",query).keySet().isEmpty(),"Missing profile uses defaults");
  Bundle p=new Bundle(query);p.putString("fontPath","unica_font:a.xml");p.putString("scene","a");p.putFloat("fontWidth",85f);
  p.putBoolean("enabled",true);p.putFloat("radius",1.25f);p.putDouble("precision",1.234567890123);p.putLong("timestamp",1234567891234L);
  p.putIntArray("grid",new int[]{1,2,3});p.putFloatArray("manualHeights",new float[]{1.5f,2.25f});p.putStringArray("names",new String[]{"a","b"});p.putLongArray("ids",new long[]{1,1234567891234L});
  Bundle axes=new Bundle();axes.putFloat("wght",620f);p.putBundle("fontAxes",axes);
  ArrayList<Bundle> list=new ArrayList<>();list.add(identity(101,2));p.putParcelableArrayList("layouts",list);
  store.commit("clock",p);
  Bundle typed=new NativeProfileStore(context).read("clock",p);
  check(typed.get("enabled") instanceof Boolean,"boolean type roundtrip");check(typed.get("radius") instanceof Float,"float type roundtrip");
  check(typed.get("precision") instanceof Double,"double type roundtrip");check(typed.get("timestamp") instanceof Long,"long type roundtrip");
  check(Arrays.equals((int[])typed.get("grid"),new int[]{1,2,3}),"int array roundtrip");
  check(Arrays.equals((float[])typed.get("manualHeights"),new float[]{1.5f,2.25f}),"float array roundtrip");
  check(Arrays.equals((String[])typed.get("names"),new String[]{"a","b"}),"string array roundtrip");
  check(((long[])typed.get("ids"))[1]==1234567891234L,"long array roundtrip");
  check(((ArrayList<?>)typed.get("layouts")).get(0) instanceof Bundle,"nested Bundle list roundtrip");
  check(Float.valueOf(620f).equals(typed.getBundle("fontAxes").get("wght")),"axis roundtrip");
  check(store.read("clock",identity(101,700)).keySet().isEmpty(),"wallpaper isolation");
  check(store.read("clock",identity(100,701)).keySet().isEmpty(),"font identity isolation");
  Bundle landscape=new Bundle(query);landscape.putInt("layoutOrientation",2);check(store.read("clock",landscape).keySet().isEmpty(),"orientation isolation");
  Bundle otherScene=new Bundle(query);otherScene.putString("scene","b");check(store.read("clock",otherScene).keySet().isEmpty(),"scene mismatch isolation");
  Bundle differentFont=new Bundle(p);differentFont.putString("fontPath","unica_font:b.xml");differentFont.putFloat("fontWidth",120f);Bundle axesB=new Bundle();axesB.putFloat("wdth",80f);differentFont.putBundle("fontAxes",axesB);store.commit("clock",differentFont);
  check(Float.valueOf(620f).equals(store.read("clock",p).getBundle("fontAxes").get("wght")),"prior font axis profile retained");
  check(Float.valueOf(80f).equals(store.read("clock",differentFont).getBundle("fontAxes").get("wdth")),"new font axis selected");
  check(Float.valueOf(85f).equals(store.read("clock",p).get("fontWidth")),"prior font width retained");
  check(Float.valueOf(120f).equals(store.read("clock",differentFont).get("fontWidth")),"new font width selected");
  Bundle imported=new Bundle(p);imported.putString("fontFile","a".repeat(64));imported.putBoolean("manual",true);store.commit("clock",imported);
  check(Boolean.FALSE.equals(store.read("clock",imported).get("manual")),"imported font disables manual stretch");
  check(!store.read("clock",imported).containsKey("manualHeights"),"imported font removes stretch heights");
  Bundle extras=new Bundle();extras.putString("title","Extras");store.commit("extras",extras);check("Extras".equals(store.read("extras",null).getString("title")),"extras independent of clock identity");
  store.commit("widgets",p);check(store.read("widgets",query).containsKey("fontPath"),"widget namespace isolated");
  Bundle display=new Bundle(p);display.putBoolean("followDisplayFont",true);display.putString("fontSourceIdentity","/data/app_fonts/0/display/DroidSans.ttf");display.putBoolean("manual",true);store.commit("clock",display);
  check(Float.valueOf(620f).equals(store.read("clock",display).getBundle("fontAxes").get("wght")),"Display font axes survive restart");
  check(!store.read("clock",display).containsKey("manualHeights"),"Display font cannot acquire Samsung HEGT");
  Bundle op1=new Bundle();op1.putString("scope","extras");Bundle next=new Bundle();next.putString("title","Atomic");op1.putBundle("profile",next);
  Bundle op2=new Bundle();op2.putString("scope","clock");op2.putBundle("profile",new Bundle());
  ArrayList<Bundle> batch=new ArrayList<>();batch.add(op1);batch.add(op2);
  expectFailure(()->store.commitBatch(batch));check("Extras".equals(store.read("extras",null).getString("title")),"Invalid second operation rolls back whole Apply");
  op2.putBundle("profile",p);store.commitBatch(batch);check("Atomic".equals(new NativeProfileStore(context).read("extras",null).getString("title")),"Whole Apply persists together");
  expectFailure(()->store.commit("clock",new Bundle()));expectFailure(()->store.read("invalid",query));
  Path database=directory.resolve("dressroom_advanced_profiles_v1.json");byte[] before=Files.readAllBytes(database);
  Bundle huge=new Bundle(p);huge.putString("oversize","x".repeat(8*1024*1024));expectFailure(()->store.commit("clock",huge));check(Arrays.equals(before,Files.readAllBytes(database)),"oversized commit preserves prior database");
  Files.writeString(database,"{broken");byte[] corrupt=Files.readAllBytes(database);expectFailure(()->store.commit("extras",extras));check(Arrays.equals(corrupt,Files.readAllBytes(database)),"corrupt file never silently overwritten");
  Files.writeString(database,"{\"schema\":99,\"profiles\":{}}");expectFailure(()->store.commit("extras",extras));check(Files.readString(database).contains("99"),"unknown schema preserved");
  System.out.println("Native profile store: "+checks+" checks passed; host doubles do not validate Android Binder or crash recovery");
 }
}
