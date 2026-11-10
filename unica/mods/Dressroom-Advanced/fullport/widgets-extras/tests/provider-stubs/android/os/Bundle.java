package android.os;
public class Bundle {
 public final java.util.Map<String,Integer> map=new java.util.HashMap<>();
 public Bundle(){}public Bundle(Bundle old){map.putAll(old.map);}
 public int getInt(String k){return map.getOrDefault(k,0);}public void putInt(String k,int v){map.put(k,v);}
}
