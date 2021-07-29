use <_impl/_tiles_wfc_impl.scad>;

// An implementation of [Wave Function Collapse](https://github.com/mxgmn/WaveFunctionCollapse)
function tile_wfc(width, height, sample) =
    tilemap_generate(tilemap(width, height, sample));

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

width = 20;
height = 20;

echo(tile_wfc(width, height, sample));
*/


