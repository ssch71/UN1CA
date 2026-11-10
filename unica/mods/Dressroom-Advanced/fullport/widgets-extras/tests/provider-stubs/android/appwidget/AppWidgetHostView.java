package android.appwidget;
public class AppWidgetHostView {
 public AppWidgetProviderInfo info;public int binds,updates;public android.os.Bundle sent;
 public AppWidgetProviderInfo getAppWidgetInfo(){return info;}public android.content.Context getContext(){return null;}
 public int getAppWidgetId(){return 72;}
 public void setAppWidget(int id,AppWidgetProviderInfo v){if(id!=72)throw new AssertionError("ID changed");info=v;binds++;}
 public void updateAppWidgetOptions(android.os.Bundle value){sent=value;updates++;}
}
