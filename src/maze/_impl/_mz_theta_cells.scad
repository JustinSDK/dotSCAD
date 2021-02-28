use <../../util/rand.scad>;
use <../../util/slice.scad>;
use <../../util/some.scad>;

NO_WALL = 0;
INWARD_WALL = 1;
CCW_WALL = 2;
INWARD_CCW_WALL = 3;

function cell(ri, ci, wallType, notVisited = true, inward = undef, outwards = undef, cw = undef, ccw = undef) = 
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
    cell[0], cell[1], cell[2], false, cell[4], cell[5], cell[6], cell[7]
];

function set_outwards(cell, outwards) = [
    cell[0], cell[1], cell[2], cell[3], cell[4], outwards, cell[6], cell[7]
];

function get_outwards(cell) = cell[5];

function add_outward(cell, ri, ci) = [
	cell[0], cell[1], cell[2], cell[3], cell[4], concat(get_outwards(cell), [[ri, ci]]), cell[6], cell[7]
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
    let(
	    cellWidth = 1 / totalRows,
		r0 = [
			for(ci=0; ci < beginingColumns; ci = ci + 1)
				cell(0, ci, INWARD_CCW_WALL)
		]
	)
	_init_theta_maze(1, [r0], totalRows, dividedRatio, cellWidth);
	
function _init_theta_maze(ri, maze, totalRows, dividedRatio, cellWidth) = 
    ri == totalRows ? maze : 
		let(
			columnLeng = columnLengOfRow(ri, cellWidth, len(maze[ri - 1]), dividedRatio),
			row = [
				for(ci = 0; ci < columnLeng; ci = ci + 1)
					cell(ri, ci, INWARD_CCW_WALL)
			]
		)
		_init_theta_maze(ri + 1, concat(maze, [row]), totalRows, dividedRatio, cellWidth);

function update_maze_row(row, cell) =
    concat(slice(row, 0, cell[1]), [cell], slice(row, cell[1] + 1));

function update_maze(maze, cell) = 
    let(
	    row = maze[cell[0]],
		u_row = update_maze_row(row, cell)
	)
    concat(slice(maze, 0, cell[0]), [u_row], slice(maze, cell[0] + 1));

function config_outwards(maze, cell_outwards_lt) = 
	_config_outwards(maze, cell_outwards_lt, len(cell_outwards_lt));

function _config_outwards(maze, cell_outwards_lt, leng, i = 0) = 
    i == leng ? maze :
	let(
	    ci = cell_outwards_lt[i][0],
		oi = cell_outwards_lt[i][1],
		c = maze[ci[0]][ci[1]],
		nc = add_outward(c, oi[0], oi[1]),
		nm = update_maze(maze, nc)
	)
	_config_outwards(nm, cell_outwards_lt, leng, i + 1);

function config_nbrs(maze) =
	let(
		outmost = len(maze) - 1,
		maze2 = [ // config empty outwards except outmost row
			for(row = maze)
			[
				for(c = row)
					get_ri(c) < outmost ? set_outwards(c, []) : c
			]
		],
		cell_outwards_lt = [
			for(row = maze2)
				for(c = row)
				let(
					ri = get_ri(c),
					ci = get_ci(c),
					r_leng = len(maze2[ri])
				)
				if(ri > 0) 
					[
					    [ri - 1, floor(ci / (r_leng / len(maze2[ri - 1])))], 
						[ri, ci]
					]
		],
		maze3 = [ // config cw, ccw, inward nbrs
			for(row = maze2)
			[
				for(c = row)
				let(
					ri = get_ri(c),
					ci = get_ci(c),
					r_leng = len(maze2[ri]),
					cw = [ri, ci > 0 ? (ci - 1) : (ci - 1 + r_leng)],
					ccw = [ri, (ci + 1) % r_leng]
				)
				ri > 0 ? 
					let(
						ratio = r_leng / len(maze2[ri - 1]),
						inward = [ri - 1, floor(ci / ratio)]
					)
					[ri, ci, c[2], c[3], inward, c[5], cw, ccw] : 
					[ri, ci, c[2], c[3], c[4], c[5], cw, ccw]
			]
		]
	)
	config_outwards(maze3, cell_outwards_lt);

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
	[
		is_undef(inward) ? [] : [maze[inward[0]][inward[1]]],
		is_undef(outwards) ? [] : [for(outward = outwards) maze[outward[0]][outward[1]]],
		is_undef(cw) ? [] : [maze[cw[0]][cw[1]]],
		is_undef(ccw) ? [] : [maze[ccw[0]][ccw[1]]]
	][dir];

function visitIN(maze, next, currentCell) =
    let(
	    wallType = get_wallType(currentCell),
		m1 = update_maze(maze, 
			    set_wallType(currentCell, wallType == INWARD_CCW_WALL ? CCW_WALL : NO_WALL)
		)
	)
	update_maze(m1, set_visited(next));

function visitOUT(maze, next, currentCell) = update_maze(
    maze, 
	cell(next[0], next[1], CCW_WALL, false, next[4], next[5], next[6], next[7])
);

function visitCW(maze, next, currentCell) = update_maze(
    maze, 
	cell(next[0], next[1], INWARD_WALL, false, next[4], next[5], next[6], next[7])
);

function visitCCW(maze, next, currentCell) = 
    let(
	    wallType = get_wallType(currentCell),
		m1 = update_maze(maze, 
			    set_wallType(currentCell, wallType == INWARD_CCW_WALL ? INWARD_WALL : NO_WALL)
		)
	)
	update_maze(m1, set_visited(next));
	
function visitNext(maze, next, currentCell, dir) = 
    dir == IN ? visitIN(maze, next, currentCell) :
	dir == OUT ? visitOUT(maze, next, currentCell) :
	dir == CW ? visitCW(maze, next, currentCell) :
	dir == CCW ? visitCCW(maze, next, currentCell) : maze;
				
function backtracker(maze, currentIndices, rows, seed) =
    let(
	    rdirs = rand_dirs(currentIndices[0] * rows + currentIndices[1], seed),
		vdirs = visitable_dirs(maze, rdirs, maze[currentIndices[0]][ currentIndices[1]]),
		vdirs_leng = len(vdirs)
	)
	vdirs_leng == 0 ? maze : // 完全沒有可造訪的方向就回溯
	                  visit_dirs(maze, currentIndices, vdirs, vdirs_leng, rows, seed); // go maze


function visit_dirs(maze, currentIndices, dirs, dirs_leng, rows, seed, i = 0) = 
    i == dirs_leng ? maze :
    let(
	    dir = dirs[i],
		cells_indices = [for(c = nextCells(maze, maze[currentIndices[0]][currentIndices[1]], dir)) [c[0], c[1]]],
		cells_leng = len(cells_indices),
		m = visit_cells(maze, currentIndices, dir, cells_indices, cells_leng, rows, seed)
	)
	visit_dirs(m, currentIndices, dirs, dirs_leng, rows, seed, i + 1);
	
function visit_cells(maze, currentIndices, dir, cells_indices, cells_leng, rows, seed, i = 0) = 
    i == cells_leng ? maze :
	let(indices = cells_indices[i])
	isVisitable(maze[indices[0]][indices[1]]) ? 
	    let(m = visitNext(maze, maze[indices[0]][indices[1]], maze[currentIndices[0]][currentIndices[1]], dir))
	    visit_cells(
		    backtracker(
			    m, 
				m[indices[0]][indices[1]],
				rows,
				seed
		    ), 
			maze[currentIndices[0]][currentIndices[1]], dir, cells_indices, cells_leng, rows, i + 1
		) : 
		visit_cells(maze, maze[currentIndices[0]][currentIndices[1]], dir, cells_indices, cells_leng, rows, seed, i + 1);
	
