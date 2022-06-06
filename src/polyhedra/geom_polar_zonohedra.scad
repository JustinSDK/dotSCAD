use <../util/sum.scad>
use <../util/flat.scad>

// http://archive.bridgesmathart.org/2021/bridges2021-7.pdf

function vertex(i, j, n, theta) = 
    i > j ? [0, 0, 0] : 
	        sum([
			    for(k = [i:j]) 
				let(
					cosa = cos(theta),
					a_i_n = 360 * k / n
				)
				[cosa * cos(a_i_n), cosa * sin(a_i_n), sin(theta)]
			]);

function rhombi(i, j, n, theta) = [
	vertex(i, j, n, theta),
	vertex(i + 1, j, n, theta),
    vertex(i + 1, -1 + j, n, theta),
	vertex(i, -1 + j, n, theta)
];

function geom_polar_zonohedra(n, theta = 35.5) = 
    let(
        points = flat([
            for(i = [0:n - 1], j = [i + 1:n + i - 1])
                rhombi(i, j, n, theta)
        ]),
        faces = [
            for(i = [0:len(points) / 4 - 1]) 
            [for(j = [0:3]) i * 4 + j]
        ]
    )
    [points, faces];