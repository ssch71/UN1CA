package android.appwidget;
public class AppWidgetManager {
 public static final AppWidgetManager INSTANCE=new AppWidgetManager();public final android.os.Bundle options=new android.os.Bundle();
 public static AppWidgetManager getInstance(android.content.Context c){return INSTANCE;}
 public android.os.Bundle getAppWidgetOptions(int id){if(id!=72)throw new AssertionError("ID changed");return options;}
}
