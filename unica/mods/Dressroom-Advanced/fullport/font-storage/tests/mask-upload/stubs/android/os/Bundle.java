package android.os;
import java.util.*;
/** Host test double for public Bundle value semantics only; never shipped. */
public class Bundle {
 private final Map<String,Object> data=new HashMap<>();
 public Bundle(){} public Bundle(Bundle b){data.putAll(b.data);}
 public Set<String> keySet(){return data.keySet();} public Object get(String k){return data.get(k);}
 public boolean containsKey(String k){return data.containsKey(k);} public void remove(String k){data.remove(k);}
 public int getInt(String k){return getInt(k,0);}public int getInt(String k,int d){Object o=get(k);return o instanceof Integer?(Integer)o:d;}
 public String getString(String k){return getString(k,null);}public String getString(String k,String d){Object o=get(k);return o instanceof String?(String)o:d;}
 public boolean getBoolean(String k){return Boolean.TRUE.equals(get(k));}
 @SuppressWarnings("unchecked") public <T> ArrayList<T> getParcelableArrayList(String k,Class<T> t){return (ArrayList<T>)get(k);}
 public Bundle getBundle(String k){return (Bundle)get(k);}
 public void putString(String k,String v){data.put(k,v);} public void putInt(String k,int v){data.put(k,v);}
 public void putFloat(String k,float v){data.put(k,v);}public void putDouble(String k,double v){data.put(k,v);}
 public void putLong(String k,long v){data.put(k,v);}public void putBoolean(String k,boolean v){data.put(k,v);}
 public void putBundle(String k,Bundle v){data.put(k,v);}public void putFloatArray(String k,float[] v){data.put(k,v);}
 public void putIntArray(String k,int[] v){data.put(k,v);}public void putLongArray(String k,long[] v){data.put(k,v);}
 public void putStringArray(String k,String[] v){data.put(k,v);}public void putParcelableArrayList(String k,ArrayList<Bundle> v){data.put(k,v);}
}
