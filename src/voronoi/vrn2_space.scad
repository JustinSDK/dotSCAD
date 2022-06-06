/**
* vrn2_space.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_space.html
*
**/

use <../util/unit_vector.scad>

module vrn2_space(size, grid_w, seed, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    function cell_pt(fcord, seed, x, y, gw, gh) = 
        let(
            nv = fcord + [x, y],
            sd_x = (nv.x + gw) % gw,
            sd_y = (nv.y + gh) % gh,                 
            sd_base = abs(sd_x + sd_y * grid_w)
        )
        (nv + rands(0.1, 0.9, 2, seed_value = seed + sd_base)) * grid_w;

    // 9-nearest-neighbor 
    function _neighbors(fcord, seed, grid_w, gw, gh) = 
        let(range = [-1:1])
        [for(y = range, x = range) cell_pt(fcord, seed, x, y, gw, gh)];

    region_size = grid_w * 3;
    half_region_size = 0.5 * region_size; 
    offset_leng = (spacing + region_size) * 0.5;
    
    module region(pt, points) {
        intersection_for(p = points) {
            v = p - pt;
            translate((pt + p) / 2 - unit_vector(v) * offset_leng)
            rotate(atan2(v.y, v.x)) 
                children();
        }
    }    
    
    sd = is_undef(seed) ? rands(0, 255, 1)[0] : seed; 


    gw = size[0] / grid_w;
    gh = size[1] / grid_w;

    cell_nbrs_lt = [
        for(cy = [-grid_w:grid_w:size.y], cx = [-grid_w:grid_w:size.x]) 
        let(
            nbrs = _neighbors(
                [floor(cx / grid_w), floor(cy / grid_w)],
                sd, 
                grid_w,
                gw, 
                gh
            ),
            p = nbrs[4],
            points = concat(
                [nbrs[0], nbrs[1], nbrs[2], nbrs[3]], 
                [for(i = [5:len(nbrs) - 1]) nbrs[i]]
            )
        )
        [p, points] 
    ];
    
    module offseted_region(pt, points) {
        if(r != 0) {
            offset(r) 
            region(pt, points) 
                children();
        }
        else {
            offset(delta = delta, chamfer = chamfer) 
            region(pt, points) 
                children();
        }     
    }
    
    for(cell_nbrs = cell_nbrs_lt) {
        if(region_type == "square") {
            offseted_region(cell_nbrs[0], cell_nbrs[1])
                square(region_size, center = true);
        }
        else {
            offseted_region(cell_nbrs[0], cell_nbrs[1])
                circle(half_region_size);          
        }
    }                
}