use <util/rand.scad>
use <experimental/tile_w2e.scad>
use <select.scad>
use <city_tile.scad>

mask = [
    [0, 1, 1, 0, 0, 0, 1, 1, 0],
    [1, 1, 1, 1, 0, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 1, 0, 0, 0]
];

rows = len(mask);
columns = len(mask[0]);

random_city(rows, columns, mask);

module random_city(rows, columns, mask) {
    tile_width = 30;
    for(tile = tile_w2e([columns, rows], mask)) {
        translate([tile.x, tile.y] * tile_width)
            city_tile(tile[2], tile_width);
    }
}