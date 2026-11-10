package dev.denver.dressroomadvanced;

public final class WidgetFormModelTest {
    public record Grid(String id,int width,int height,int x,int y,int sx,int sy,boolean drag,int xu,int yu,boolean available){
        public String getGridId(){return id;}public int getX(){return x;}public int getY(){return y;}
        public int getSecondaryX(){return sx;}public int getSecondaryY(){return sy;}
        public int getXPositionUnit(){return xu;}public int getYPositionUnit(){return yu;}
        public boolean isDragAllowed(){return drag;}public boolean getAvailable(){return available;}
        public Grid copy(String id,int w,int h,int x,int y,int sx,int sy,boolean drag,int xu,int yu,boolean a){return new Grid(id,w,h,x,y,sx,sy,drag,xu,yu,a);}
    }
    public static void main(String[]args)throws Exception{
        if(!WidgetFormModel.tallPicker(false,true,true,2)||WidgetFormModel.tallPicker(false,true,false,2)||WidgetFormModel.tallPicker(false,false,true,2)||WidgetFormModel.tallPicker(false,true,true,1))throw new AssertionError("Tall picker draft scope");
        if(WidgetFormModel.code(2,2)!=8||WidgetFormModel.code(2,1)!=2||WidgetFormModel.code(4,2)!=16||WidgetFormModel.code(1,2)!=0)throw new AssertionError("Samsung native form encoding");
        if(!WidgetFormModel.supported(10,2,2)||WidgetFormModel.supported(1,2,2))throw new AssertionError("Real Weather Detail/Simple form distinction lost");
        Grid old=new Grid("72;com.weather/.Detail;0",2,1,3,0,0,2,true,1,1,true);
        Grid updated=(Grid)WidgetFormModel.copy(old,new int[]{3,0,2,2},false);
        if(updated.height()!=2||updated.width()!=2||!updated.id().equals(old.id())||updated.sx()!=old.sx()||updated.sy()!=old.sy()||updated.xu()!=old.xu())throw new AssertionError("Resize loses persisted native identity/opposite orientation");
        Grid rotated=(Grid)WidgetFormModel.copy(updated,new int[]{1,2,2,2},true);
        if(rotated.x()!=3||rotated.y()!=0||rotated.sx()!=1||rotated.sy()!=2)throw new AssertionError("Wrong orientation edited");
        int[][] screenshot={{0,0,2,2},{2,0,1,1},{2,1,1,1},{3,0,2,2}};
        if(!WidgetLayout.positionsValid(5,2,screenshot)||WidgetLayout.positionsValid(4,2,screenshot))throw new AssertionError("Mixed 2x2/1x1 layout capacity");
        System.out.println("Mixed provider forms, native identity persistence, and screenshot 5x2 layout passed");
    }
}
