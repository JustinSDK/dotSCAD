function sf_splines(ctrl_pts, row_spline, column_spline) =
    let(
        leng_ctrl_pts = len(ctrl_pts),
        cspline = is_undef(column_spline) ? row_spline : column_spline,
        r_pts = [
		    for(r = 0; r < leng_ctrl_pts; r = r + 1)
				row_spline(ctrl_pts[r])
		],
        leng_r_pts0 = len(r_pts[0]),
        leng_r_pts = len(r_pts)
	)
    [
	    for(c = 0; c < leng_r_pts0; c = c + 1)
            cspline([for(r = 0; r < leng_r_pts; r = r + 1) r_pts[r][c]]) 
    ];

/*
use <bspline_curve.scad>;
use <function_grapher.scad>;
use <surface/sf_splines.scad>;

ctrl_pts = [
    [[0, 0, 20],  [60, 0, -35],   [90, 0, 60],    [200, 0, 5]],
    [[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
    [[0, 100, 0], [60, 120, 35],  [90, 100, 60],  [200, 100, 45]],
    [[0, 150, 0], [60, 150, -35], [90, 180, 60],  [200, 150, 45]]
];

thickness = 2;
t_step = 0.05;
degrees = 2;

row_spline = function(points) bspline_curve(t_step, degrees, points);
column_spline = function(points) bspline_curve(t_step, degrees, points);

function_grapher(sf_splines(ctrl_pts, row_spline, column_spline), thickness);
*/

/*

use <bezier_curve.scad>;
use <function_grapher.scad>;
use <surface/sf_splines.scad>;

ctrl_pts = [
    [[0, 0, 20],  [60, 0, -35],   [90, 0, 60],    [200, 0, 5]],
    [[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
    [[0, 100, 0], [60, 120, 35],  [90, 100, 60],  [200, 100, 45]],
    [[0, 150, 0], [60, 150, -35], [90, 180, 60],  [200, 150, 45]]
];

thickness = 2;
t_step = 0.05;

row_spline = function(points) bezier_curve(t_step, points);
column_spline = function(points) bezier_curve(t_step, points);

function_grapher(sf_splines(ctrl_pts, row_spline, column_spline), thickness);

*/

/*

use <curve.scad>;
use <function_grapher.scad>;
use <surface/sf_splines.scad>;

use <hull_polyline3d.scad>;

ctrl_pts = [
    [[0, 0, 20],  [20, 0, -15], [90, 0, 30], [200, 0, 5]],
    [[0, 20, 30], [30, 30, -25], [80, 40, 20], [100, 50, 5]],
    [[0, 100, 0], [20, 90, 15],  [90, 100, 10],  [100, 100, 45]],
    [[0, 110, 0], [40, 120, -35], [90, 130, 20],  [120, 120, 15]]
];

thickness = 2;
t_step = 0.05;

row_spline = function(points) curve(t_step, points);
column_spline = function(points) curve(t_step, points);

function_grapher(sf_splines(ctrl_pts, row_spline, column_spline), thickness);

for(i = [0:3]) {
    %hull_polyline3d(ctrl_pts[i]);
    #hull_polyline3d(curve(t_step, ctrl_pts[i]));
}

*/