use <experimental/_impl/_mz_hamiltonian_impl.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_get.scad>;
use <util/sort.scad>;
use <util/dedup.scad>;

function mz_hamiltonian(rows, columns, start) =
    let(
        blocks = mz_blocks(
            [1, 1],  
            rows, columns
        ),
        all = concat(
            [
                for(block = blocks)
                let(
                    x = mz_get(block, "x"),
                    y = mz_get(block, "y"),
                    wall_type = mz_get(block, "w"),
                    pts = wall_type == "UPPER_WALL" ? _mz_hamiltonian_upper(x, y) :
                          wall_type == "RIGHT_WALL" ? _mz_hamiltonian_right(x, y) :
                          wall_type == "UPPER_RIGHT_WALL" ? _mz_hamiltonian_upper_right(x, y) : []
                )
                each pts
            ],
            [for(x = [0:columns * 2 - 1]) [x, 0]],
            [for(y = [0:rows * 2 - 1]) [0, y]]
        ),
        dot_pts = dedup(sort(all, by = "vt"), sorted = true)
    )
    _mz_hamiltonian_travel(dot_pts, start, rows * columns * 4);