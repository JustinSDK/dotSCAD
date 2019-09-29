include <line3d.scad>;
include <turtle/t3d.scad>;

module tree(t, leng, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, width) {
    if(leng > leng_limit) {
        t2 = t3d(t, "xforward", leng = leng);

        line3d(
            t3d(t, "point"), t3d(t2, "point"), 
            width);

        tree(
            t3d(t2, "zturn", angle = angleZ),
            leng * leng_scale1, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, 
            width);

        tree(
            t3d(t2, "xturn", angle = angleX), 
            leng * leng_scale2, leng_scale1, leng_scale2, leng_limit, 
            angleZ, angleX, 
            width);
    }    
}

leng = 20;
leng_limit = 1;
leng_scale1 = 0.4;
leng_scale2 = 0.9;
angleZ = 60;
angleX = 135;
width = 2;

t = t3d(point = [0, 0, 0]);

tree(t, leng, leng_scale1, leng_scale2, leng_limit, 
     angleZ, angleX, width);