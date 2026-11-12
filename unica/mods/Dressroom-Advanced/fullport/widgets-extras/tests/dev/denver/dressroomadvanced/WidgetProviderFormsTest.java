package dev.denver.dressroomadvanced;
import android.appwidget.*;
public final class WidgetProviderFormsTest {
 public static void main(String[]args){
  AppWidgetHostView host=new AppWidgetHostView();AppWidgetProviderInfo shared=new AppWidgetProviderInfo();shared.targetCellWidth=2;shared.targetCellHeight=1;host.info=shared;
  AppWidgetManager.INSTANCE.options.putInt("configuredCalendar",123);
  WidgetProviderForms.apply(host,2,2,10);
  if(host.binds!=1||host.updates!=1||host.info==shared||shared.targetCellHeight!=1||host.info.targetCellHeight!=2)throw new AssertionError("Real host form must rebind without mutating shared provider");
  if(host.sent.getInt("semWidgetSize")!=8||host.sent.getInt("semAppWidgetColumnSpan")!=2||host.sent.getInt("semAppWidgetRowSpan")!=2||host.sent.getInt("appWidgetCategory")!=8192)throw new AssertionError("Samsung provider form options wrong");
  if(host.sent.getInt("configuredCalendar")!=123||AppWidgetManager.INSTANCE.options.getInt("semWidgetSize")!=0)throw new AssertionError("Existing state lost or service options mutated");
  WidgetProviderForms.apply(host,1,1,10);if(host.updates!=1)throw new AssertionError("Unsupported provider layout sent");
  WidgetProviderForms.apply(host,2,2,1);if(host.updates!=1)throw new AssertionError("SimpleWeather turned into fake full layout");
  Object manager=new Object();host.info=shared;host.binds=host.updates=0;
  WidgetProviderForms.preview(manager,host,2,2,10);WidgetProviderForms.endPreview(manager,false);
  if(host.info.targetCellHeight!=1||host.sent.getInt("semWidgetSize")!=2||host.sent.getInt("configuredCalendar")!=123)throw new AssertionError("Cancel did not restore original real form/options");
  WidgetProviderForms.preview(manager,host,2,2,10);WidgetProviderForms.endPreview(manager,true);
  if(host.info.targetCellHeight!=2||host.sent.getInt("semWidgetSize")!=8)throw new AssertionError("Apply incorrectly rolled back real form");
  AppWidgetHostView sibling=new AppWidgetHostView();sibling.info=shared;
  if(sibling.info.targetCellHeight!=1)throw new AssertionError("Sibling instance provider metadata changed");
  System.out.println("Production provider rebind: real2x2 form, stableID, isolatedmetadata/options, supportedforms passed");
 }
}
