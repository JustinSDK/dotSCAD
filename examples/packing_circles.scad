use <util/rand.scad>;

size = [500, 250];
min_radius = 5;
max_radius = 50;
total_circles = 100;

function _packing_circles_out_of_range(size, c) =
    c[0] + c[2] >= size[0] || 
    c[0] - c[2] <= 0 ||
    c[1] + c[2] >= size[1] || 
    c[1] - c[2] <= 0;
    
function _packing_circles_overlapping(circles, c, i = 0) = 
    i == len(circles) ? false : 
        let(
            x = c[0] - circles[i][0],
            y = c[1] - circles[i][1],
            a = c[2] + circles[i][2],
            collision = a ^ 2 >= x ^2 + y ^ 2
        )
        collision || _packing_circles_overlapping(circles, c, i + 1);
    
function _packing_circles_packable(size, circles, c) =
    !_packing_circles_overlapping(circles, c) && 
    !_packing_circles_out_of_range(size, c);

function _packing_circles_new_min_circle(size, min_radius, attempts, circles, i = 0) = 
    i == attempts ? [] :
        let(c = [rand() * size[0], rand() * size[1], min_radius])
        _packing_circles_packable(size, circles, c) ? c : 
        _packing_circles_new_min_circle(size, min_radius, attempts, circles, i + 1);

function _packing_circles_increase_radius(size, circles, c, max_radius) = 
    c[2] == max_radius || !_packing_circles_packable(size, circles, c) ? 
        [c[0], c[1], c[2] - 1] : 
        _packing_circles_increase_radius(size, circles, [c[0], c[1], c[2] + 1], max_radius);


function _packing_circles_new_circle(size, min_radius, max_radius, attempts, circles) = 
    let(c = _packing_circles_new_min_circle(size, min_radius, attempts, circles))
    c == [] ? [] : _packing_circles_increase_radius(size, circles, c, max_radius);

function _packing_circles(size, min_radius, max_radius, total_circles, attempts, circles = [], i = 0) =
    i == total_circles ? circles :
    let(c = _packing_circles_new_circle(size, min_radius, max_radius, attempts, circles))
    c == [] ? _packing_circles(size, min_radius, max_radius, total_circles, attempts, circles) :
    _packing_circles(size, min_radius, max_radius, total_circles, attempts, [each circles, c], i + 1);

function packing_circles(size, min_radius, max_radius, total_circles, attempts = 100) = 
    _packing_circles(is_num(size) ? [size, size] : size, min_radius, max_radius, total_circles, attempts);
    
circles = packing_circles(size, min_radius, max_radius, total_circles);
mr = max([for(c = circles) c[2]]);
translate([0, 0, mr]) 
    for(c = circles) {
        translate([c[0], c[1]])
            sphere(c[2], $fn = 48);
    }

for(c = circles) {
    translate([c[0], c[1]])
    linear_extrude(mr) 
        circle(c[2]/ 3, $fn = 48);
}
linear_extrude(1) square(size);
