/**
* vrn3_space.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_space.html
*
**/

use <__comm__/__angy_angz.scad>;

// slow but workable
module vrn3_space(size, grid_w, seed, spacing = 1) {
    function _neighbors(fcord, seed, grid_w) = [
        let(range = [-1:1])
        for(z = range, y = range, x = range)    
        let(
            nx = fcord.x + x,
            ny = fcord.y + y,
            nz = fcord.z + z,
            sd_base = abs(nx + ny * grid_w + nz * grid_w * grid_w),
            sds =  rands(0.1, 0.9, 3, seed_value = seed + sd_base)
        )
        ([nx, ny, nz] + sds) * grid_w
    ];    
    
    space_size = grid_w * 3;    
    offset_leng = (spacing + space_size) * 0.5;

    function normalize(v) = v / norm(v);
    
    module space(pt, points) {
        intersection_for(p = points) {            
            v = p - pt;
            ryz = __angy_angz(p, pt);
            translate((pt + p) / 2 - normalize(v) * offset_leng)
            rotate([0, -ryz[0], ryz[1]]) 
                cube(space_size, center = true); 
        }
    }    
    
    sd = is_undef(seed) ? rands(0, 255, 1)[0] : seed; 

    // 27-nearest-neighbor cells
    cell_nbrs_lt = [
        for(cz = [0:grid_w:size.z], cy = [0:grid_w:size.y], cx = [0:grid_w:size.x]) 
        let(
            nbrs = _neighbors(
                [floor(cx / grid_w), floor(cy / grid_w), floor(cz / grid_w)],
                sd, 
                grid_w
            ),
            p = nbrs[13],
            points = concat(
                [for(i = [0:12]) nbrs[i]], 
                [for(i = [14:len(nbrs) - 1]) nbrs[i]]
            )
        )
        [p, points] 
    ];
    
    for(cell_nbrs = cell_nbrs_lt) {
        space(cell_nbrs[0], cell_nbrs[1]);
    }    
}