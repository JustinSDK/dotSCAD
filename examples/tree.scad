include <turtle/turtle3d.scad>;
include <line3d.scad>;

module tree(t, leng, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, width) {
    if(leng > leng_limit) {
        t2 = turtle3d("xu_move", t, leng);

        polyline3d(
            [turtle3d("pt", t), turtle3d("pt", t2)], 
            width);

        tree(
            turtle3d("zu_turn", t2, angleZ),
            leng * leng_scale1, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, 
            width);

        tree(
            turtle3d("xu_turn", t2, angleX), 
            leng * leng_scale2, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, 
            width);
    }    
}

leng = 100;
leng_limit = 1;
leng_scale1 = 0.4;
leng_scale2 = 0.9;
angleZ = 60;
angleX = 135;
width = 2;

t = turtle3d("create");

tree(t, leng, leng_scale1, leng_scale2, leng_limit, 
     angleZ, angleX, width);