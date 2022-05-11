function _create(pt, unit_vts) = 
    [
        is_undef(pt) ? [0, 0, 0] : pt, 
        is_undef(unit_vts) ? [[1, 0, 0], [0, 1, 0], [0, 0, 1]] : unit_vts
    ];

function _pt(turtle) = turtle[0];
function _unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _xu_forward(turtle, leng) = _create(
    _pt(turtle) + _unit_vts(turtle).x * leng,
    _unit_vts(turtle)
);

// forward the turtle in the y' direction
function _yu_forward(turtle, leng) = _create(
    _pt(turtle) + _unit_vts(turtle).y * leng,
    _unit_vts(turtle)
);

// forward the turtle in the z' direction
function _zu_forward(turtle, leng) = _create(
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
    
function _set_point(t, point) = 
    _create(point, _unit_vts(t));

function _set_unit_vectors(t, unit_vectors) =
    _create(_pt(t), unit_vectors);

function _get(t, cmd) = 
    cmd == "point" ? _pt(t) : 
    cmd == "unit_vectors" ? _unit_vts(t) : 
    assert(false, "unknown command");

function _set(t, point, unit_vectors) = 
    !is_undef(point) ? _set_point(t, point) :
    !is_undef(unit_vectors) ? _set_unit_vectors(t, unit_vectors) :
    assert(false, "no target to set");

function _cmd(t, cmd, point, unit_vectors, leng, angle) = 
    cmd == "forward" || cmd == "xforward" ? _xu_forward(t, leng) : 
    cmd == "roll" ? _xu_turn(t, -angle) : 
    cmd == "pitch" ? _yu_turn(t, -angle) : 
    cmd == "turn" || cmd == "zturn" ? _zu_turn(t, angle) : 
    cmd == "xturn" ? _xu_turn(t, angle) : 
    cmd == "yturn" ? _yu_turn(t, angle) : 
    cmd == "yforward" ? _yu_forward(t, leng) : 
    cmd == "zforward" ? _zu_forward(t, leng) : 
    _get(t, cmd);

function _cmdline(cmd, t, arg) = 
    is_undef(arg) ? _get(t, cmd) : 
    cmd == "forward" || cmd == "xforward" ? _xu_forward(t, arg) : 
    cmd == "roll" ? _xu_turn(t, -arg) : 
    cmd == "pitch" ? _yu_turn(t, -arg) : 
    cmd == "turn" || cmd == "zturn" ? _zu_turn(t, arg) : 
    cmd == "point" ? _set_point(t, point) : 
    cmd == "xturn" ? _xu_turn(t, arg) : 
    cmd == "yturn" ? _yu_turn(t, arg) : 
    cmd == "yforward" ? _yu_forward(t, arg) : 
    cmd == "zforward" ? _zu_forward(t, arg) : 
    cmd == "unit_vectors" ? _set_unit_vectors(t, unit_vectors) :  
    assert(false, "unknown command");

function _cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _cmds(_cmdline(cmd, t, arg), cmds, i + 1);

function _t3d_impl(t, cmd, point, unit_vectors, leng, angle) =
    is_undef(t) ? _create(point, unit_vectors) :
    is_undef(cmd) ? _set(t, point, unit_vectors) :
    is_string(cmd) ? _cmd(t, cmd, point, unit_vectors, leng, angle) :
                     _cmds(t, cmd);