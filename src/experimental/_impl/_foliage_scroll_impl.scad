use <util/count.scad>

MAX_ANGLE = 720;

function vt(center, r, startAngle, angleSign, angle) = 
    let(
        a = angle * angleSign + startAngle,
        s = (MAX_ANGLE - angle) / MAX_ANGLE
    )
    [
        center.x + r * cos(a) * s, 
        center.y + r * sin(a) * s
    ];

function spiral(center, r, startAngle, angleSign = 1, angle = 0, path) = 
[
    center, 
    r, 
    startAngle,
    angleSign,
    angle,
    is_undef(path) ? [vt(center, r, startAngle, angleSign, angle)] :  path
];

function spiral_center(spiral) = spiral[0];
function spiral_r(spiral) = spiral[1];
function spiral_startAngle(spiral) = spiral[2];
function spiral_angleSign(spiral) = spiral[3];
function spiral_angle(spiral) = spiral[4];
function spiral_path(spiral) = spiral[5];

function spiral_step(spiral, angle_step) = 
    let(    
        c = spiral_center(spiral),
        r = spiral_r(spiral),
        sa = spiral_startAngle(spiral),
        as = spiral_angleSign(spiral),
        a = spiral_angle(spiral) + angle_step
    )
    spiral(
        c,
        r,
        sa,
        as,
        a,
        [each spiral_path(spiral), vt(c, r, sa, as, a)]
    );

function _foliage_scroll(size, spirals, max_spirals, min_radius, angle_step, done) =
    let(
        more_spirals = try_add_spiral(size, spirals, max_spirals, min_radius, done),
        nx_spirals = [
            for(i = 0; i < len(more_spirals); i = i + 1)
            if(i < done) more_spirals[i] else spiral_step(more_spirals[i], angle_step)
        ],
        nx_done = count(nx_spirals, function(s) spiral_angle(s) > 630)
    )
    nx_done < len(nx_spirals)? _foliage_scroll(size, nx_spirals, max_spirals, min_radius, angle_step, nx_done) : nx_spirals;

function try_add_spiral(size, spirals, max_spirals, min_radius, done) = 
    let(
        leng = len(spirals),
        more_spirals = [
            each spirals,
            each [
                for(i = done; i < leng; i = i + 1) 
                let(maybeSpiral = try_create_spiral(size, spirals, i, min_radius))
                if(!is_undef(maybeSpiral)) maybeSpiral
            ]
        ],
        leng_more_spirals = len(more_spirals)
    )
    leng_more_spirals > max_spirals ? [for(i = [0:max_spirals - 1]) more_spirals[i]] : more_spirals;
    
function try_create_spiral(size, spirals, i, min_radius) = 
    let(spiral = spirals[i])
    spiral_angle(spiral) <= 270 ? undef :
    let(
        r = spiral_r(spiral),
        cr = r * rands(0.5, 1.5, 1)[0]
    )
    cr < min_radius ? undef : 
    let(
        offAngle = rands(0, 270, 1)[0],
        offR = r * (MAX_ANGLE - offAngle) / MAX_ANGLE + cr,
        angleSign = spiral_angleSign(spiral),
        ca = offAngle * angleSign + spiral_startAngle(spiral) + 180,
        center = spiral_center(spiral),
        cx = center.x + offR * cos(ca - 180),
        cy = center.y + offR * sin(ca - 180)
    )
    out_size(size, cx, cy, cr) || overlapped(spirals, i, cx, cy, cr) ? undef : spiral([cx, cy], cr, ca, -angleSign);

function out_size(size, cx, cy, cr) =
    let(half_width = size.x / 2, half_height = size.y / 2)
    cx < -half_width + cr || cx > half_width - cr || cy < -half_height + cr || cy > half_height - cr;
    
function overlapped(spirals, i, cx, cy, cr, j = 0) = 
    j == len(spirals) ? false :
    j == i ? overlapped(spirals, i, cx, cy, cr, j + 1) :
    let(
        spiral = spirals[j],
        leng = norm(spiral_center(spiral) - [cx, cy]),
        sa = startAngle(cx, cy, spiral),
        d = cr * 1.5,
        r = spiral_r(spiral)
    )
    dist(leng, r, sa) <  d || dist(leng, r, sa + 360) < d || overlapped(spirals, i, cx, cy, cr, j + 1);
    
function startAngle(cx, cy, spiral) = 
    let(
        center = spiral_center(spiral),
        sa = (atan2((cy - center.y), (cx - center.x)) - spiral_startAngle(spiral)) % 360
    )
    abs((sa + spiral_angleSign(spiral) * 360) % 360);
    
function dist(leng, r, a) = abs(leng - r * (MAX_ANGLE - a) / MAX_ANGLE);
