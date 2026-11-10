package dev.denver.dressroomadvanced;
import android.app.*;import android.view.*;import android.graphics.Rect;
public class PanelDismissTest {
 static int checks,closed;
 static void check(boolean b,String s){checks++;if(!b)throw new AssertionError(s);}
 static void event(Object source,int action,float x,float y){AdvancedPanelDismiss.touch(source,new MotionEvent(action,x,y));}
 static AdvancedPanelDismiss floating(Activity a,View panel){a.window.decor.focused=false;panel.params=new WindowManager.LayoutParams();panel.x=40;panel.y=900;panel.bounds=new Rect(0,0,420,400);AdvancedPanelDismiss d=new AdvancedPanelDismiss(a,panel,null,()->true,()->closed++);d.activate();return d;}
 public static void main(String[]args){
  Activity a=new Activity();View panel=new View();AdvancedPanelDismiss clock=floating(a,panel);
  Rect r=new Rect();check(ScreenBounds.visible(panel,r)&&r.left==40&&r.top==900&&r.bottom==1300,"screen window origin missing");
  event(panel,0,100,1000);event(panel,1,100,1000);check(closed==0,"inside clock control dismissed panel");
  event(panel,4,100,1000);check(closed==0,"spurious OUTSIDE over content");
  Dialog picker=new Dialog();picker.showing=true;AdvancedPanelDismiss.protectCurrent(picker);
  event(panel,4,0,0);check(closed==0,"child option dialog dismissed parent");picker.showing=false;
  panel.focused=false;event(panel,4,0,0);check(closed==0,"dropdown focus dismissed parent");panel.focused=true;
  panel.insets.ime=true;a.manager.metrics.insets.insets.bottom=600;
  event(panel,4,300,2200);event(panel,4,0,0);check(closed==0,"keyboard touch dismissed parent");panel.insets.ime=false;
  event(a,0,800,500);event(a,2,850,500);event(a,1,850,500);check(closed==0,"outside drag counted as tap");
  event(a,0,800,500);event(a,5,800,500);event(a,1,800,500);check(closed==0,"pinch counted as tap");
  event(a,0,800,500);event(a,1,100,1000);check(closed==0,"release inside counted as outside");
  event(a,0,800,500);event(a,1,800,500);check(closed==1,"outside clock tap did not dismiss");
  check(((WindowManager.LayoutParams)panel.params).flags==0x10,"window flags not restored");
  View widget=new View();AdvancedPanelDismiss widgets=floating(a,widget);
  event(widget,0,100,1100);event(widget,1,100,1100);check(closed==1,"inside widget control dismissed");
  event(widget,4,800,500);check(closed==2,"outside widget tap did not dismiss");
  AdvancedPanelDismiss floating=floating(a,new View());AdvancedPanelDismiss.clear();check(!AdvancedPanelDismiss.shownFor(a),"session cleanup left panel active");floating.activate();check(!AdvancedPanelDismiss.shownFor(a),"queued attach revived a closed session");
  View content=new View(),header=new View();content.root=a.window.decor;header.root=a.window.decor;content.bounds=new Rect(50,1000,500,1400);header.bounds=new Rect(50,950,500,1000);a.window.decor.focused=true;
  new AdvancedPanelDismiss(a,content,header,()->true,()->closed++).activate();
  event(a,0,100,970);event(a,1,100,970);check(closed==2,"embedded header dismissed");
  event(a,0,800,500);event(a,3,800,500);event(a,1,800,500);check(closed==2,"cancelled gesture dismissed");
  event(a,0,800,500);event(a,1,800,500);check(closed==3,"embedded outside tap did not dismiss");
  check(DressroomModule.errors==0,"unexpected dismissal error");
  View failing=new View();failing.params=new WindowManager.LayoutParams();failing.x=40;failing.y=900;failing.bounds=new Rect(0,0,420,400);a.window.decor.focused=false;
  new AdvancedPanelDismiss(a,failing,null,()->true,()->{throw new Exception("native close failed");}).activate();
  event(failing,4,800,500);check(AdvancedPanelDismiss.shownFor(a),"close failure lost active panel");check(DressroomModule.errors==1,"close failure not reported");
  failing.shown=false;event(failing,4,800,500);check(!AdvancedPanelDismiss.shownFor(a),"hidden sheet left active tracking");check(((WindowManager.LayoutParams)failing.params).flags==0x10,"hidden sheet retained flags");
  System.out.println("Advanced panel dismissal: "+checks+" production-controller checks passed; simulated Android windows");
 }
}
