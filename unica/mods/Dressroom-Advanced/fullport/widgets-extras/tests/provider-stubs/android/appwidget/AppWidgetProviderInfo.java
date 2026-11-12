package android.appwidget;
public class AppWidgetProviderInfo implements Cloneable {
 public int targetCellWidth,targetCellHeight;public android.content.ComponentName provider;
 public AppWidgetProviderInfo clone(){try{return(AppWidgetProviderInfo)super.clone();}catch(Exception e){throw new AssertionError(e);}}
}
