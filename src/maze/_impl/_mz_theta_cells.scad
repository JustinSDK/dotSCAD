use <../../util/rand.scad>
use <../../util/some.scad>

NO_WALL = 0;
INWARD_WALL = 1;
CCW_WALL = 2;
INWARD_CCW_WALL = 3;
UNVISITED = true;
VISITED = false;

function cell(ri, ci, wallType, notVisited = UNVISITED, inward = undef, outwards = undef, cw = undef, ccw = undef) = 
    [ri, ci, wallType, notVisited, inward, outwards, cw, ccw];

function get_ri(cell) = cell[0];
function get_ci(cell) = cell[1];
function get_wallType(cell) = cell[2];
function get_inward(cell) = cell[4];
function get_outwards(cell) = cell[5];
function get_cw(cell) = cell[6];
function get_ccw(cell) = cell[7];

function set_wallType(cell, wallType) = [
    cell[0], cell[1], wallType, cell[3], cell[4], cell[5], cell[6], cell[7]
];

function set_visited(cell) = [
    cell[0], cell[1], cell[2], VISITED, cell[4], cell[5], cell[6], cell[7]
];

function set_outwards(cell, outwards) = [
    cell[0], cell[1], cell[2], cell[3], cell[4], outwards, cell[6], cell[7]
];

function get_outwards(cell) = cell[5];

function add_outward(cell, outward) = [
	cell[0], cell[1], cell[2], cell[3], cell[4], [each get_outwards(cell), outward], cell[6], cell[7]
];

function columnLengOfRow(ri, cellWidth, previousColumnLeng, dividedRatio) = 
    let(
	    r = ri * cellWidth,
		circumference = 2 * PI * r,
		estimatedOutWallWidth = circumference / previousColumnLeng,
		ratio = estimatedOutWallWidth / cellWidth >= dividedRatio ? 2 : 1
	)
	previousColumnLeng * ratio;

function init_theta_maze(totalRows, beginingColumns, dividedRatio = 1.5) =
    let(cellWidth = 1 / totalRows)
	[
		for(
			ri = 0,
			columnLeng = -1,
			row = [for(ci = 0; ci < beginingColumns; ci = ci + 1) cell(0, ci, INWARD_CCW_WALL)]; 
			ri < totalRows; 
			ri = ri + 1,
			columnLeng = ri < totalRows ? columnLengOfRow(ri, cellWidth, len(row), dividedRatio) : undef,
			row = ri < totalRows ? [for(ci = 0; ci < columnLeng; ci = ci + 1) cell(ri, ci, INWARD_CCW_WALL)] : undef
		)	
		row
	];

function update_maze_row(row, cell) =
    let(leng = len(row))
    [for(i = 0; i < leng; i = i + 1) i == cell[1] ? cell : row[i]];

function update_maze(maze, cell) = 
    let(
	    row = maze[cell[0]],
		u_row = update_maze_row(row, cell),
		leng = len(maze)
	)
	[for(i = 0; i < leng; i = i + 1) i == cell[0] ? u_row : maze[i]];

function config_outwards(maze, cell_outwards_lt) = 
	_config_outwards(maze, cell_outwards_lt, len(cell_outwards_lt));

function cell_from(maze, cell_idx) = maze[cell_idx[0]][cell_idx[1]]; 

function _config_outwards(maze, cell_outwards_lt, leng, i = 0) = 
    i == leng ? maze :
	_config_outwards(
		update_maze(maze, 
		    add_outward(
				cell_from(maze, cell_outwards_lt[i][0]), 
				cell_outwards_lt[i][1]
		    )
		), 
		cell_outwards_lt, 
		leng, 
		i + 1
	);

function config_nbrs(maze) =
	let(
		outmost = len(maze) - 1,
		mz_empty_outs = [ // config empty outwards except outmost row
			for(row = maze)
			[
				for(c = row)
					get_ri(c) < outmost ? set_outwards(c, []) : c
			]
		],
		cell_outwards_lt = [
			for(row = mz_empty_outs, c = row)
				let(
					ri = get_ri(c),
					ci = get_ci(c),
					r_leng = len(mz_empty_outs[ri])
				)
				if(ri > 0) 
					[
					    [ri - 1, floor(ci / (r_leng / len(mz_empty_outs[ri - 1])))], 
						[ri, ci]
					]
		],
		mz_cw_ccw_inward = [ // config cw, ccw, inward nbrs
			for(row = mz_empty_outs)
			[
				for(c = row)
				let(
					ri = get_ri(c),
					ci = get_ci(c),
					r_leng = len(mz_empty_outs[ri]),
					cw = [ri, ci > 0 ? (ci - 1) : (ci - 1 + r_leng)],
					ccw = [ri, (ci + 1) % r_leng]
				)
				ri > 0 ? 
					let(
						ratio = r_leng / len(mz_empty_outs[ri - 1]),
						inward = [ri - 1, floor(ci / ratio)]
					)
					[ri, ci, c[2], c[3], inward, c[5], cw, ccw] : 
					[ri, ci, c[2], c[3], c[4], c[5], cw, ccw]
			]
		]
	)
	config_outwards(mz_cw_ccw_inward, cell_outwards_lt);

// function isVisitable(cell) = cell[3];
isVisitable = function(cell) cell[3];

// dirs
IN = 0;  
OUT = 1;  
CW = 2;  
CCW = 3;  

_rand_dir_table = [
    [0, 1, 2, 3],
    [0, 1, 3, 2],
    [0, 2, 1, 3],
    [0, 2, 3, 1],
    [0, 3, 1, 2],
    [0, 3, 2, 1],
    [1, 0, 2, 3],
    [1, 0, 3, 2],
    [1, 2, 0, 3],
    [1, 2, 3, 0],
    [1, 3, 0, 2],
    [1, 3, 2, 0],
    [2, 0, 1, 3],
    [2, 0, 3, 1],
    [2, 1, 0, 3],
    [2, 1, 3, 0],
    [2, 3, 0, 1],
    [2, 3, 1, 0],
    [3, 0, 1, 2],
    [3, 0, 2, 1],
    [3, 1, 0, 2],
    [3, 1, 2, 0],
    [3, 2, 0, 1],
    [3, 2, 1, 0]
];

function rand_dirs(c, seed) =
   let(r = is_undef(seed) ? rands(0, 24, 1) : rands(0, 24, 1, c + seed))
    _rand_dir_table[round(r[0])]; 

function visitable_dirs(maze, dirs, currentCell) =
    [
	    for(dir = dirs)
		let(nxcs = nextCells(maze, currentCell, dir))
		if(some(nxcs, isVisitable))
		dir
	];

function nextCells(maze, cell, dir) = 
    let(
	    inward = get_inward(cell), 
		outwards = get_outwards(cell),
		cw = get_cw(cell), 
		ccw = get_ccw(cell)
	)
	dir == 0 ? (is_undef(inward) ? [] : [cell_from(maze, inward)]) :
	dir == 1 ? (is_undef(outwards) ? [] : [for(outward = outwards) cell_from(maze, outward)]) :
	dir == 2 ? (is_undef(cw) ? [] : [cell_from(maze, cw)]) :
	           (is_undef(ccw) ? [] : [cell_from(maze, ccw)]);

function visitIN(maze, next, currentCell) =
	update_maze(
		update_maze(
		    maze, 
			set_wallType(
				currentCell, 
				get_wallType(currentCell) == INWARD_CCW_WALL ? CCW_WALL : NO_WALL
			)
		), 
		set_visited(next)
	);

function visitOUT(maze, next, currentCell) = update_maze(
    maze, 
	cell(next[0], next[1], CCW_WALL, VISITED, next[4], next[5], next[6], next[7])
);

function visitCW(maze, next, currentCell) = update_maze(
    maze, 
	cell(next[0], next[1], INWARD_WALL, VISITED, next[4], next[5], next[6], next[7])
);

function visitCCW(maze, next, currentCell) = 
	update_maze(
		update_maze(
			maze, 
			set_wallType(
				currentCell, 
				get_wallType(currentCell) == INWARD_CCW_WALL ? INWARD_WALL : NO_WALL
			)
		), 
		set_visited(next)
	);
	
function visitNext(maze, next, currentCell, dir) = 
    dir == IN ? visitIN(maze, next, currentCell) :
	dir == OUT ? visitOUT(maze, next, currentCell) :
	dir == CW ? visitCW(maze, next, currentCell) :
	dir == CCW ? visitCCW(maze, next, currentCell) : maze;

function backtracker(maze, current_idx, rows, seed) =
    let(
	    rdirs = rand_dirs(current_idx[0] * rows + current_idx[1], seed),
		vdirs = visitable_dirs(maze, rdirs, cell_from(maze, current_idx)),
		vdirs_leng = len(vdirs)
	)
	vdirs_leng == 0 ? maze :
	                  visit_dirs(maze, current_idx, vdirs, vdirs_leng, rows, seed); // go maze

function visit_dirs(maze, current_idx, dirs, dirs_leng, rows, seed, i = 0) = 
    i == dirs_leng ? maze :
    let(
	    dir = dirs[i],
		cell_idxs = [for(c = nextCells(maze, cell_from(maze, current_idx), dir)) [c[0], c[1]]],
		m = visit_cells(maze, current_idx, dir, cell_idxs, len(cell_idxs), rows, seed)
	)
	visit_dirs(m, current_idx, dirs, dirs_leng, rows, seed, i + 1);

function visit_cells(maze, current_idx, dir, cell_idxs, cells_leng, rows, seed, i = 0) = 
    i == cells_leng ? maze :
	let(cell_idx = cell_idxs[i])
	isVisitable(cell_from(maze, cell_idx)) ? 
	    let(mz = visitNext(maze, cell_from(maze, cell_idx), cell_from(maze, current_idx), dir))
	    visit_cells(
		    backtracker(
			    mz, 
				cell_from(mz, cell_idx),
				rows,
				seed
		    ), 
			cell_from(maze, current_idx), dir, cell_idxs, cells_leng, rows, i + 1
		) : 
		visit_cells(maze, cell_from(maze, current_idx), dir, cell_idxs, cells_leng, rows, seed, i + 1);
	
