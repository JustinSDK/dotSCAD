/**
* along_with.scad
*
* Puts children along the given path. If there's only one child, 
* it will put the child for each point. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html
*
**/ 

module along_with(points) {
    if($children == 1) {
        for(i = [0:len(points) - 1]) {
            translate(points[i]) 
                children(0);
        }
    } else {
        for(i = [0:min(len(points), $children) - 1]) {
            translate(points[i]) 
                children(i);
        }
    }
}