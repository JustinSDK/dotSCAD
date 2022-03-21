use <_impl/_tiles_wfc_impl.scad>;
use <../util/rand.scad>;

// An implementation of [Wave Function Collapse](https://github.com/mxgmn/WaveFunctionCollapse)
function tile_wfc(size, sample) =
    let(
        tm = tilemap(size[0], size[1], sample),
        // random start
        x = floor(rand(size[0] * 0.25, size[0] * 0.75)),
        y = floor(rand(size[1] * 0.25, size[1] * 0.75)),
        first_collasped_propagated = tilemap_propagate([
			tilemap_width(tm),
			tilemap_height(tm),
			tilemap_compatibilities(tm),
			wf_collapse(tilemap_wf(tm), x, y)
		], x, y),
        notCollapsedCoords = wf_not_collapsed_coords(tilemap_wf(first_collasped_propagated))
    )
    tilemap_generate(first_collasped_propagated, notCollapsedCoords);

/*

sample = [
    ["S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S"],
    ["S",  "S", "C0", "CN", "CN", "CN", "CN", "CN", "CN", "CN", "C3",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],
    ["S",  "S", "CW",  "L",  "L",  "L",  "L",  "L",  "L",  "L", "CE",  "S",  "S"],    
    ["S",  "S", "C1", "CS", "CS", "CS", "CS", "CS", "CS", "CS", "C2",  "S",  "S"],
    ["S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S",  "S"]
];

size = [20, 20];

echo(tile_wfc(size, sample));
*/


