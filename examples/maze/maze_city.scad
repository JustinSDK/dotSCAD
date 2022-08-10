use <maze/mz_square_initialize.scad>
use <maze/mz_square.scad>
use <maze/mz_tiles.scad>
use <util/rand.scad>
use <../tiles/city_tile.scad>

rows = 10;
columns = 10;
skyscraper_prs = 0.05;

maze_city(rows, columns, skyscraper_prs);

module maze_city(rows, columns, skyscraper_prs) {
    mask = [for(r = [0:rows - 1])
	    [for(c = [0:columns - 1])
		rand() < skyscraper_prs ? 0 : 1]
	];

    cells = mz_square(rows, columns, [0, 0], init_cells = mz_square_initialize(rows, columns, mask));

    tiles = mz_tiles(cells);

    tile_width = 30;
    for(tile = tiles) {
        translate([tile.x, tile.y] * tile_width)
            city_tile(tile[2], tile_width);
    }
}