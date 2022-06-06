use <../../matrix/m_rotation.scad>

function _create(pt, unit_vts) = [pt, unit_vts];
function _create_default() = _create(
    [0, 0, 0], 
    // unit vectors from the turtle's viewpoint
    [[1, 0, 0], [0, 1, 0], [0, 0, 1]] 
);

function _pt(turtle) = turtle[0];
function _unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _xu_move(turtle, leng) = _create(
    _pt(turtle) + _unit_vts(turtle).x * leng,
    _unit_vts(turtle)
);

// forward the turtle in the y' direction
function _yu_move(turtle, leng) = _create(
    _pt(turtle) + _unit_vts(turtle).y * leng,
    _unit_vts(turtle)
);

// forward the turtle in the z' direction
function _zu_move(turtle, leng) = _create(
    _pt(turtle) + _unit_vts(turtle).z * leng,
    _unit_vts(turtle)
);

function _q_rotation(a, v) = 
    let(
        uv = v / norm(v),
        s = sin(a / 2) * uv,
        w = sin(a) * uv,

        xx = 2 * s.x ^ 2,
        yy = 2 * s.y ^ 2,
        zz = 2 * s.z ^ 2,

        xy = 2 * s.x * s.y,
        xz = 2 * s.x * s.z,
        yz = 2 * s.y * s.z
    )
    [
        [1 - yy - zz, xy - w.z, xz + w.y],
        [xy + w.z, 1 - xx - zz, yz - w.x],
        [xz - w.y, yz + w.x, 1 - xx - yy]
    ];
    
// turn the turtle around the x'-axis
// return a new unit vector
function _xu_turn(turtle, a) = 
    let(
        unit_vts = _unit_vts(turtle),
        xu = unit_vts.x,
        m = _q_rotation(a, xu)
    )
    _create(
        _pt(turtle),
        [
            xu, 
            m * unit_vts.y, 
            m * unit_vts.z
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _yu_turn(turtle, a) = 
    let(
        unit_vts = _unit_vts(turtle),
        yu = unit_vts.y,
        m = _q_rotation(a, yu)
    )
    _create(
        _pt(turtle),
        [
            m * unit_vts.x, 
            yu, 
            m * unit_vts.z
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _zu_turn(turtle, a) = 
    let(
        unit_vts = _unit_vts(turtle),
        zu = unit_vts.z,
        m = _q_rotation(a, zu)
    )
    _create(
        _pt(turtle),
        [
            m * unit_vts.x, 
            m * unit_vts.y,
            zu
        ]
    );

function _create_cmd(arg1, arg2) = 
    is_undef(arg1) && is_undef(arg2) ? _create_default() : 
    !is_undef(arg1) && !is_undef(arg2) ? _create(arg1, arg2) : undef;
    
function _chain_move(cmd, arg1, arg2) =
    cmd == "forward" || cmd == "xu_move" ? _xu_move(arg1, arg2) : 
    cmd == "yu_move" ? _yu_move(arg1, arg2) : 
    cmd == "zu_move" ? _zu_move(arg1, arg2) : _chain_turn(cmd, arg1, arg2);
    
function _chain_turn(cmd, arg1, arg2) = 
    cmd == "roll" ? _xu_turn(arg1, -arg2) :
    cmd == "pitch" ? _yu_turn(arg1, -arg2) : 
    cmd == "turn" || cmd == "zu_turn" ? _zu_turn(arg1, arg2) :
    cmd == "xu_turn" ? _xu_turn(arg1, arg2) : 
    cmd == "yu_turn" ? _yu_turn(arg1, arg2) : _chain_one_arg(cmd, arg1);    

function _chain_one_arg(cmd, arg) = 
    cmd == "pt" ? _pt(arg) : 
    cmd == "unit_vts" ? _unit_vts(arg) : undef;
    
function _turtle3d_impl(cmd, arg1, arg2) =
    cmd == "create" ? 
        _create_cmd(arg1, arg2) : 
        _chain_move(cmd, arg1, arg2);    