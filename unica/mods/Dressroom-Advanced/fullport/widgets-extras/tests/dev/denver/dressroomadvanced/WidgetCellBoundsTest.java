package dev.denver.dressroomadvanced;
import java.util.Arrays;
public final class WidgetCellBoundsTest {
    private static void eq(int[] a,int... b){if(!Arrays.equals(a,b))throw new AssertionError(Arrays.toString(a));}
    public static void main(String[]args){
        eq(WidgetCellBounds.fit(-5,12,2,2,4,3),0,1,2,2);
        eq(WidgetCellBounds.fit(3,0,8,8,4,2),0,0,4,2);
        eq(WidgetCellBounds.fit(2,1,0,0,4,3),2,1,1,1);
        if(WidgetCellBounds.overlaps(new int[]{0,0,1,1},new int[]{1,0,1,1}))throw new AssertionError("Touching edges collide");
        if(!WidgetCellBounds.overlaps(new int[]{0,0,2,2},new int[]{1,1,2,2}))throw new AssertionError("Overlap accepted");
        for(int cols=1;cols<=8;cols++)for(int rows=1;rows<=8;rows++)for(int x=-2;x<=10;x++)for(int y=-2;y<=10;y++){
            int[] a=WidgetCellBounds.fit(x,y,x+3,y+3,cols,rows);
            if(a[0]<0||a[1]<0||a[2]<1||a[3]<1||a[0]+a[2]>cols||a[1]+a[3]>rows)throw new AssertionError("Out of bounds");
        }
        System.out.println("Widget grid bounds, pinch span limits, and collision tests passed");
    }
}
