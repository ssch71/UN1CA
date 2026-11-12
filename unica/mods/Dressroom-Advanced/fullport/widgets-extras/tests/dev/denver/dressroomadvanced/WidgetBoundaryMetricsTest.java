package dev.denver.dressroomadvanced;

public final class WidgetBoundaryMetricsTest {
    public static final class Grid {
        int col,row;
        public void setCol(int x){col=x;} public void setRow(int x){row=x;}
    }
    public static final class Size {
        int width,height,disabledWidth,disabledHeight,expandWidth,unit,inner,side;float scale,previewScale,radius,previewRadius;
        public void setContainerWidth(int x){width=x;} public void setContainerHeight(int x){height=x;}
        public void setDisableWidth(int x){disabledWidth=x;}public void setDisableHeight(int x){disabledHeight=x;}
        public void setDisableExpandWidth(int x){expandWidth=x;}public void setWidgetUnitSize(int x){unit=x;}
        public void setWidgetInnerSizePadding(int x){inner=x;}public void setWidgetSideMargin(int x){side=x;}
        public void setScaleFactor(float x){scale=x;}public void setPreviewLayoutScale(float x){previewScale=x;}
        public void setRadius(float x){radius=x;}public void setPreviewRadius(float x){previewRadius=x;}
    }
    public static final class StaleProvider {
        public int getColumn(){throw new AssertionError("Draft grid must not be overwritten by provider capacity");}
        public int getRow(){throw new AssertionError("Draft grid must not be overwritten by provider capacity");}
        public float getUnitSize(){return 100;}public float getPadding(){return 5;}
        public float getScaleFactor(){return 1.25f;}public float radius(int cells){return 20;}
    }
    static void verify(Size s,Grid g,int cols,int rows,int w,int h){
        if(g.col!=cols||g.row!=rows||s.width!=w||s.height!=h||s.disabledWidth!=w||s.disabledHeight!=h||s.expandWidth!=w)
            throw new AssertionError("Visible boundary and native capacity disagree");
        if(s.scale!=1.25f||s.previewScale!=1.25f||s.previewRadius!=16)throw new AssertionError("Scale/radius lost");
    }
    public static void main(String[]args)throws Exception{
        Size size=new Size();Grid grid=new Grid();StaleProvider provider=new StaleProvider();
        WidgetBoundaryMetrics.apply(size,grid,provider,4,1);verify(size,grid,4,1,430,100);
        WidgetBoundaryMetrics.apply(size,grid,provider,4,2);verify(size,grid,4,2,430,210);
        WidgetBoundaryMetrics.apply(size,grid,provider,2,4);verify(size,grid,2,4,210,430);
        WidgetBoundaryMetrics.apply(size,grid,provider,4,1);verify(size,grid,4,1,430,100);
        System.out.println("Widget boundary 4x1 -> 4x2 -> 2x4 -> reset geometry passed with stale provider");
    }
}
