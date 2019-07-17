/**
* trim_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-trim_shape.html
*
**/

include <__comm__/__to3d.scad>;
include <__comm__/__line_intersection.scad>;
include <__comm__/__in_line.scad>;
include <__comm__/__lines_from.scad>;

function _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon) =
    let(
        p = __line_intersection(lines[i], line, epsilon)
    )
    (p != [] && __in_line(line, p, epsilon) && __in_line(lines[i], p, epsilon)) ? [i, p] : _trim_shape_any_intersection(lines, line, lines_leng, i + 1, epsilon);

// return [idx, [x, y]] or []
function _trim_shape_any_intersection(lines, line, lines_leng, i, epsilon) =
    i == lines_leng ? [] : _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon);

function _trim_sub(lines, leng, epsilon) = 
    let(
        current_line = lines[0],
        next_line = lines[1],
        lines_from_next = [for(j = 1; j < leng; j = j + 1) lines[j]],
        lines_from_next2 = [for(j = 2; j < leng; j = j + 1) lines[j]],
        current_p = current_line[0],
        leng_lines_from_next2 = len(lines_from_next2),
        inter_p = _trim_shape_any_intersection(lines_from_next2, current_line, leng_lines_from_next2, 0, epsilon)
    )
    // no intersecting pt, collect current_p and trim remain lines
    inter_p == [] ? (concat([current_p], _trim_shape_trim_lines(lines_from_next, epsilon))) : (
        // collect current_p, intersecting pt and the last pt
        (leng == 3 || (inter_p[0] == (leng_lines_from_next2 - 1))) ? [current_p, inter_p[1], lines[leng - 1]] : (
            // collect current_p, intersecting pt and trim remain lines
            concat([current_p, inter_p[1]], 
                _trim_shape_trim_lines([for(i = inter_p[0] + 1; i < leng_lines_from_next2; i = i + 1) lines_from_next2[i]], epsilon)
            )
        )
    );
    
function _trim_shape_trim_lines(lines, epsilon) = 
    let(leng = len(lines))
    leng > 2 ? _trim_sub(lines, leng, epsilon) : _trim_shape_collect_pts_from(lines, leng);

function _trim_shape_collect_pts_from(lines, leng) = 
    concat([for(line = lines) line[0]], [lines[leng - 1][1]]);

function trim_shape(shape_pts, from, to, epsilon = 0.0001) = 
    let(
        pts = [for(i = from; i <= to; i = i + 1) shape_pts[i]],
        trimmed = _trim_shape_trim_lines(__lines_from(pts), epsilon)
    )
    len(shape_pts) == len(trimmed) ? trimmed : trim_shape(trimmed, 0, len(trimmed) - 1, epsilon);
