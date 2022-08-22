use <../__comm__/__line_intersection.scad>
use <../__comm__/__in_line.scad>
use <../__comm__/__lines_from.scad>

function _any_intersection_sub(lines, line, lines_leng, i, epsilon) =
    let(p = __line_intersection2(lines[i], line, false, epsilon))
    p != [] ? [i, p] : _any_intersection(lines, line, lines_leng, i + 1, epsilon);

// return [idx, [x, y]] or []
function _any_intersection(lines, line, lines_leng, i, epsilon) =
    i == lines_leng ? [] : _any_intersection_sub(lines, line, lines_leng, i, epsilon);

function _trim_sub(lines, leng, epsilon) = 
    let(
        current_line = lines[0],
        next_line = lines[1],
        lines_from_next = [for(j = 1; j < leng; j = j + 1) lines[j]],
        lines_from_next2 = [for(j = 2; j < leng; j = j + 1) lines[j]],
        current_p = current_line[0],
        leng_lines_from_next2 = len(lines_from_next2),
        inter_p = _any_intersection(lines_from_next2, current_line, leng_lines_from_next2, 0, epsilon)
    )
    // no intersecting pt, collect current_p and trim remain lines
    inter_p == [] ? [current_p, each _trim_lines(lines_from_next, epsilon)] : 
    // collect current_p, intersecting pt and the last pt
    leng == 3 || (inter_p.x == (leng_lines_from_next2 - 1)) ? [current_p, inter_p.y, lines[leng - 1]] : 
        // collect current_p, intersecting pt and trim remain lines
        [current_p, inter_p.y, each _trim_lines([for(i = inter_p.x + 1; i < leng_lines_from_next2; i = i + 1) lines_from_next2[i]], epsilon)];
    
function _trim_lines(lines, epsilon) = 
    let(leng = len(lines))
    leng > 2 ? _trim_sub(lines, leng, epsilon) : _collect_pts_from(lines, leng);

function _collect_pts_from(lines, leng) = 
    [each [for(line = lines) line[0]], lines[leng - 1][1]];

function _trim_shape_impl(shape_pts, from, to, epsilon) = 
    let(
        pts = [for(i = from; i <= to; i = i + 1) shape_pts[i]],
        trimmed = _trim_lines(__lines_from(pts), epsilon)
    )
    len(shape_pts) == len(trimmed) ? trimmed : _trim_shape_impl(trimmed, 0, len(trimmed) - 1, epsilon);
