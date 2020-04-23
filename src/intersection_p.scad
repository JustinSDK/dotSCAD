use <__comm__/__line_intersection.scad>;
use <__comm__/__in_line.scad>;

function intersection_p(line_pts1, line_pts2, ext = false, epsilon = 0.0001) =
     let(
         pt = __line_intersection(line_pts1, line_pts2, epsilon)
     )
     ext ? pt :
     pt != [] && __in_line(line_pts1, pt, epsilon) && __in_line(line_pts2, pt, epsilon) ? pt : [];