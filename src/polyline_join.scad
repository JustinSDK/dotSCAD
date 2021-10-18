/**
* polyline_join.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline_join.html
*
**/

module polyline_join(points) {
    leng = len(points);
    
    module hull_line(index) {
        hull() {
            translate(points[index]) 
                children();
            translate(points[index + 1]) 
                children();
        }
    }

    module hull_line2(index) {
        hull() {
            translate(points[index]) 
                children(0);
            translate(points[index + 1]) 
                children(1);
        }
    }

    if($children == 1) {
        for(i = [0:leng - 2]) {
            hull_line(i)
                children();
        }
    }
    else {
        for(i = [0:min(leng, $children) - 2]) {
            hull_line2(i) {
                children(i);
                children(i + 1);
            }
        }
    }
}