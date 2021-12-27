use <maze/mz_square_initialize.scad>;
use <maze/mz_wang_tiles.scad>;
use <util/rand.scad>;
use <city_tile.scad>;

rows = 10;
columns = 10;
skyscraper_prs = 0.05;

maze_city(rows, columns, skyscraper_prs);

module maze_city(rows, columns, skyscraper_prs) {
    mask = [for(r = [0:rows - 1])
	    [for(c = [0:columns - 1])
		rand() < skyscraper_prs ? 0 : 1]
	];

    tiles = mz_wang_tiles(
        rows, columns, [0, 0], 
        init_cells = mz_square_initialize(rows, columns, mask)
    );
    tile_width = 30;
    for(tile = tiles) {
        x = tile[0];
        y = tile[1];
        i = tile[2];
        translate([x, y] * tile_width)
            city_tile(i);
    }
}