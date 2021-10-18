/**
* select.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-select.html
*
**/

module select(i) {
    if(is_undef(i)) {
        children();
    }
    else {
        children(i);
    }
}	