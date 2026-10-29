package io.mesalabs.rezoss.ai;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.textclassifier.ConversationAction;
import java.lang.reflect.*;
import java.util.*;
/** Transfers generated Samsung-parser results to the existing notification callback. */
public final class NativeReplyBridge {
 private static final Map<Object,List<String>> pending=Collections.synchronizedMap(new WeakHashMap<Object,List<String>>());
 private static Object get(Object object,String method)throws Exception{return object.getClass().getMethod(method).invoke(object);}
 private static boolean enabled(Context context)throws Exception{
  return (Boolean)Class.forName("io.mesalabs.rezoss.ai.NativeNowNudgeRoute").getMethod("enabled",Context.class).invoke(null,context);
 }
 // Busy group chats re-request on every message; each generation takes 10-20 s
 // on the NPU, so results arrive for a notification that was already replaced,
 // the NPU never idles (heat, throttling) and in-app requests from the keyboard
 // queue behind it until they fail. Notification replies are best effort:
 // generate at most once per conversation per window, never more often than
 // GLOBAL_GAP_MS overall, and not at all while the screen is off or the device
 // is already hot.
 private static final long CONVERSATION_WINDOW_MS=60000;
 private static final long GLOBAL_GAP_MS=30000;
 private static final Map<Object,Boolean> approved=Collections.synchronizedMap(new WeakHashMap<Object,Boolean>());
 private static final Map<String,Long> lastStart=new HashMap<>();
 private static long lastGlobal;
 private static String conversationKey(Object param){
  for(Method m:param.getClass().getMethods()){
   if(m.getParameterTypes().length!=0||m.getReturnType()!=String.class)continue;
   String n=m.getName().toLowerCase(Locale.ROOT);
   if(!n.contains("key")&&!n.contains("conversationid")&&!n.contains("threadid"))continue;
   try{Object v=m.invoke(param);if(v instanceof String&&!((String)v).isEmpty())return (String)v;}catch(Exception ignored){}
  }
  return null;
 }
 private static String skipReason(Context context){
  try{
   android.os.PowerManager pm=(android.os.PowerManager)context.getSystemService(Context.POWER_SERVICE);
   if(pm!=null){
    if(!pm.isInteractive())return "screen_off";
    if(pm.getCurrentThermalStatus()>=android.os.PowerManager.THERMAL_STATUS_MODERATE)return "thermal="+pm.getCurrentThermalStatus();
    if(pm.isPowerSaveMode())return "power_save";
   }
  }catch(Exception ignored){}
  return null;
 }
 private static boolean throttled(Context context,Object param){
  String reason=skipReason(context);
  if(reason!=null){Log.i("RezossNudgeClient","Skipped reply request reason="+reason);return true;}
  String key=conversationKey(param);if(key==null)key="*";
  long now=android.os.SystemClock.elapsedRealtime();
  synchronized(lastStart){
   if(lastGlobal!=0&&now-lastGlobal<GLOBAL_GAP_MS){Log.i("RezossNudgeClient","Skipped reply request reason=global age="+(now-lastGlobal));return true;}
   Long last=lastStart.get(key);
   if(last!=null&&now-last<CONVERSATION_WINDOW_MS){Log.i("RezossNudgeClient","Skipped repeated reply request key#"+Integer.toHexString(key.hashCode())+" age="+(now-last));return true;}
   lastStart.put(key,now);lastGlobal=now;
   if(lastStart.size()>64)lastStart.clear();
  }
  Log.i("RezossNudgeClient","Starting reply request key#"+Integer.toHexString(key.hashCode()));
  return false;
 }
 private static boolean eligible(Context context,Object param)throws Exception{
  return enabled(context)&&(Boolean)get(param,"isOnSmartReply")&&!(Boolean)get(param,"isOnDisplayNudge")&&(Boolean)get(param,"hasCallback");
 }
 public static boolean shouldGenerateNow(Context context,Object param){
  try{
   if(approved.containsKey(param))return true;
   if(!eligible(context,param)||throttled(context,param))return false;
   approved.put(param,Boolean.TRUE);return true;
  }
  catch(Exception e){Log.e("RezossNudgeClient","Notification profile rejected",e);return false;}
 }
 private static String clean(String value){
  String text=value.trim().replaceFirst("^(?:[-*•]|[0-9]+[.)])\\s+", "").trim();
  if(text.startsWith("\""))text=text.substring(1).trim();
  if(text.endsWith("\""))text=text.substring(0,text.length()-1).trim();
  for(int i=0;i<3;i++)text=text.replaceFirst("(?i)^me\\s*:\\s*", "").replaceFirst("(?i)(?:^|\\s+)me\\s*:\\s*$", "").trim();
  return text;
 }
 public static void record(Context context,Object param,List<?> generated){
  if(approved.remove(param)==null)return;
  List<String> replies=new ArrayList<>();for(Object value:generated){if(value instanceof String){String text=clean((String)value);if(!text.isEmpty()&&!replies.contains(text))replies.add(text);}if(replies.size()==3)break;}
  if(!replies.isEmpty())pending.put(param,replies);
 }
 public static Object merge(Object param,Object original){
  List<String> replies=pending.remove(param);if(replies==null)return original;
  try{
   Object result=Class.forName("com.samsung.android.smartsuggestions.service.smartreply.base.SmartReplyResult")
    .getConstructor(List.class,List.class,List.class,String.class,Map.class)
    .newInstance(get(original,"getSuggestedItems"),replies,get(original,"getSuggestedActions"),get(original,"getErrorMessage"),get(original,"getExtras"));
   Log.i("RezossNudgeClient","Delivered generated notification replies="+replies.size());return result;
  }catch(Exception e){Log.e("RezossNudgeClient","Reply callback conversion failed",e);return original;}
 }
 public static void addReplyActions(Context context,List<ConversationAction> actions,Object result){
  try{if(!enabled(context))return;int count=0;
   for(Object value:(List<?>)get(result,"getSuggestedReplies")){
    if(!(value instanceof String))continue;
    String reply=clean((String)value);if(reply.isEmpty())continue;
    Bundle extras=new Bundle();extras.putBoolean("now_nudge",true);extras.putString("source","suggested_replies");
    actions.add(new ConversationAction.Builder(ConversationAction.TYPE_TEXT_REPLY).setTextReply(reply).setConfidenceScore(.5f).setExtras(extras).build());
    if(++count==3)break;
   }
  }catch(Exception e){Log.e("RezossNudgeClient","Reply action conversion failed",e);}
 }
}
