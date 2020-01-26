function _t3d_x(pt) = pt[0];
function _t3d_y(pt) = pt[1];
function _t3d_z(pt) = pt[2];

function _t3d_pt3D(x, y, z) = [x, y, z];

function _t3d_create(pt, unit_vts) = 
    [
        is_undef(pt) ? _t3d_pt3D(0, 0, 0) : pt, 
        is_undef(unit_vts) ? [_t3d_pt3D(1, 0, 0), _t3d_pt3D(0, 1, 0), _t3d_pt3D(0, 0, 1)] : unit_vts
    ];

function _t3d_plus(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) + n, _t3d_y(pt) + n, _t3d_z(pt) + n);
function _t3d_minus(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) - n, _t3d_y(pt) - n, _t3d_z(pt) + n);
function _t3d_mlt(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) * n, _t3d_y(pt) * n, _t3d_z(pt) * n);
function _t3d_div(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) / n, _t3d_y(pt) / n, _t3d_z(pt) / n);
function _t3d_neg(pt, n) = 
    _t3d_mlt(pt, -1);

function _t3d_ptPlus(pt1, pt2) = 
    _t3d_pt3D(
        _t3d_x(pt1) + _t3d_x(pt2), 
        _t3d_y(pt1) + _t3d_y(pt2), 
        _t3d_z(pt1) + _t3d_z(pt2)
    );

function _t3d_pt(turtle) = turtle[0];
function _t3d_unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _t3d_xu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(_t3d_pt(turtle), _t3d_mlt(_t3d_unit_vts(turtle)[0], leng)),
    _t3d_unit_vts(turtle)
);

// forward the turtle in the y' direction
function _t3d_yu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(_t3d_pt(turtle), _t3d_mlt(_t3d_unit_vts(turtle)[1], leng)),
    _t3d_unit_vts(turtle)
);

// forward the turtle in the z' direction
function _t3d_zu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(
        _t3d_pt(turtle), 
        _t3d_mlt(_t3d_unit_vts(turtle)[2], leng)
    ),
    _t3d_unit_vts(turtle)
);

// turn the turtle around the x'-axis
// return a new unit vector
function _t3d_xu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_unit_vts(turtle)[0], 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[1], cosa), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], sina)
            ), 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[1]), sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _t3d_yu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], cosa), 
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[2]), sina)
            ),
            _t3d_unit_vts(turtle)[1], 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _t3d_zu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], cosa), 
                _t3d_mlt(_t3d_unit_vts(turtle)[1], sina)
            ),
            _t3d_ptPlus(
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[0]), sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[1], cosa)
            ),
            _t3d_unit_vts(turtle)[2], 
        ]
    );
    
function _t3d_set_point(t, point) = 
    _t3d_create(point, _t3d_unit_vts(t));

function _t3d_set_unit_vectors(t, unit_vectors) =
    _t3d_create(_t3d_pt(t), unit_vectors);

function _t3d_get(t, cmd) = 
    cmd == "point" ? _t3d_pt(t) : 
    cmd == "unit_vectors" ? _t3d_unit_vts(t) : 
    assert(false, "unknown command");

function _t3d_set(t, point, unit_vectors) = 
    !is_undef(point) ? _t3d_set_point(t, point) :
    !is_undef(unit_vectors) ? _t3d_set_unit_vectors(t, unit_vectors) :
    assert(false, "no target to set");

function _t3d_cmd(t, cmd, point, unit_vectors, leng, angle) = 
    cmd == "xforward" ? _t3d_xu_forward(t, leng) : 
    cmd == "yforward" ? _t3d_yu_forward(t, leng) : 
    cmd == "zforward" ? _t3d_zu_forward(t, leng) : 
    cmd == "xturn" ? _t3d_xu_turn(t, angle) : 
    cmd == "yturn" ? _t3d_yu_turn(t, angle) : 
    cmd == "zturn" ? _t3d_zu_turn(t, angle) : 
    _t3d_get(t, cmd);

function _t3d_cmdline(cmd, t, arg) = 
    is_undef(arg) ? _t3d_get(t, cmd) : 
    cmd == "xforward" ? _t3d_xu_forward(t, arg) : 
    cmd == "yforward" ? _t3d_yu_forward(t, arg) : 
    cmd == "zforward" ? _t3d_zu_forward(t, arg) : 
    cmd == "xturn" ? _t3d_xu_turn(t, arg) : 
    cmd == "yturn" ? _t3d_yu_turn(t, arg) : 
    cmd == "zturn" ? _t3d_zu_turn(t, arg) : 
    cmd == "point" ? _t3d_set_point(t, point) : 
    cmd == "unit_vectors" ? _t3d_set_unit_vectors(t, unit_vectors) :  
    assert(false, "unknown command");

function _t3d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t3d_cmds(_t3d_cmdline(cmd, t, arg), cmds, i + 1);

function _t3d_impl(t, cmd, point, unit_vectors, leng, angle) =
    is_undef(t) ? _t3d_create(point, unit_vectors) :
    is_undef(cmd) ? _t3d_set(t, point, unit_vectors) :
    is_string(cmd) ? _t3d_cmd(t, cmd, point, unit_vectors, leng, angle) :
                     _t3d_cmds(t, cmd);