use <../../matrix/m_rotation.scad>;

function _turtle3d_create(pt, unit_vts) = [pt, unit_vts];
function _turtle3d_create_default() = _turtle3d_create(
    [0, 0, 0], 
    // unit vectors from the turtle's viewpoint
    [[1, 0, 0], [0, 1, 0], [0, 0, 1]] 
);

function _turtle3d_pt(turtle) = turtle[0];
function _turtle3d_unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _turtle3d_xu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_pt(turtle) + _turtle3d_unit_vts(turtle).x * leng,
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the y' direction
function _turtle3d_yu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_pt(turtle) + _turtle3d_unit_vts(turtle).y * leng,
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the z' direction
function _turtle3d_zu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_pt(turtle) + _turtle3d_unit_vts(turtle).z * leng,
    _turtle3d_unit_vts(turtle)
);

// turn the turtle around the x'-axis
// return a new unit vector
function _turtle3d_xu_turn(turtle, a) = 
    let(
        unit_vts = _turtle3d_unit_vts(turtle),
        xu = unit_vts.x,
        m = m_rotation(a, xu),
        nyu = m * [each unit_vts.y, 1],
        nzu = m * [each unit_vts.z, 1]
    )
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            xu, 
            [nyu.x, nyu.y, nyu.z], 
            [nzu.x, nzu.y, nzu.z]
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _turtle3d_yu_turn(turtle, a) = 
    let(
        unit_vts = _turtle3d_unit_vts(turtle),
        yu = unit_vts.y,
        m = m_rotation(a, yu),
        nxu = m * [each unit_vts.x, 1],
        nzu = m * [each unit_vts.z, 1]
    )
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            [nxu.x, nxu.y, nxu.z], 
            yu, 
            [nzu.x, nzu.y, nzu.z]
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _turtle3d_zu_turn(turtle, a) = 
    let(
        unit_vts = _turtle3d_unit_vts(turtle),
        zu = unit_vts.z,
        m = m_rotation(a, zu),
        nxu = m * [each unit_vts.x, 1],
        nyu = m * [each unit_vts.y, 1]
    )
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            [nxu.x, nxu.y, nxu.z], 
            [nyu.x, nyu.y, nyu.z],
            zu
        ]
    );

function _turtle3d_create_cmd(arg1, arg2) = 
    is_undef(arg1) && is_undef(arg2) ? _turtle3d_create_default() : 
    !is_undef(arg1) && !is_undef(arg2) ? _turtle3d_create(arg1, arg2) : undef;
    
function _turtle3d_chain_move(cmd, arg1, arg2) =
    cmd == "xu_move" || cmd == "forward" ? _turtle3d_xu_move(arg1, arg2) : 
    cmd == "yu_move" ? _turtle3d_yu_move(arg1, arg2) : 
    cmd == "zu_move" ? _turtle3d_zu_move(arg1, arg2) : _turtle3d_chain_turn(cmd, arg1, arg2);
    
function _turtle3d_chain_turn(cmd, arg1, arg2) = 
    cmd == "xu_turn" ? _turtle3d_xu_turn(arg1, arg2) : 
    cmd == "roll" ? _turtle3d_xu_turn(arg1, -arg2) :
    cmd == "yu_turn" ? _turtle3d_yu_turn(arg1, arg2) : 
    cmd == "pitch" ? _turtle3d_yu_turn(arg1, -arg2) : 
    cmd == "zu_turn" || cmd == "turn" ? _turtle3d_zu_turn(arg1, arg2) : _turtle3d_chain_one_arg(cmd, arg1);    

function _turtle3d_chain_one_arg(cmd, arg) = 
    cmd == "pt" ? _turtle3d_pt(arg) : 
    cmd == "unit_vts" ? _turtle3d_unit_vts(arg) : undef;
    
function _turtle3d_impl(cmd, arg1, arg2) =
    cmd == "create" ? 
        _turtle3d_create_cmd(arg1, arg2) : 
        _turtle3d_chain_move(cmd, arg1, arg2);    