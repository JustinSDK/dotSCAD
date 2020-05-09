function _turtle3d_x(pt) = pt[0];
function _turtle3d_y(pt) = pt[1];
function _turtle3d_z(pt) = pt[2];

function _turtle3d_pt3D(x, y, z) = [x, y, z];

function _turtle3d_create(pt, unit_vts) = [pt, unit_vts];
function _turtle3d_create_default() = _turtle3d_create(
    _turtle3d_pt3D(0, 0, 0), 
    // unit vectors from the turtle's viewpoint
    [_turtle3d_pt3D(1, 0, 0), _turtle3d_pt3D(0, 1, 0), _turtle3d_pt3D(0, 0, 1)] 
);

function _turtle3d_plus(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) + n, _turtle3d_y(pt) + n, _turtle3d_z(pt) + n);
function _turtle3d_minus(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) - n, _turtle3d_y(pt) - n, _turtle3d_z(pt) + n);
function _turtle3d_mlt(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) * n, _turtle3d_y(pt) * n, _turtle3d_z(pt) * n);
function _turtle3d_div(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) / n, _turtle3d_y(pt) / n, _turtle3d_z(pt) / n);
function _turtle3d_neg(pt, n) = 
    _turtle3d_mlt(pt, -1);

function _turtle3d_ptPlus(pt1, pt2) = 
    _turtle3d_pt3D(
        _turtle3d_x(pt1) + _turtle3d_x(pt2), 
        _turtle3d_y(pt1) + _turtle3d_y(pt2), 
        _turtle3d_z(pt1) + _turtle3d_z(pt2)
    );


function _turtle3d_pt(turtle) = turtle[0];
function _turtle3d_unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _turtle3d_xu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(_turtle3d_pt(turtle), _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], leng)),
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the y' direction
function _turtle3d_yu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(_turtle3d_pt(turtle), _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], leng)),
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the z' direction
function _turtle3d_zu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(
        _turtle3d_pt(turtle), 
        _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], leng)
    ),
    _turtle3d_unit_vts(turtle)
);

// turn the turtle around the x'-axis
// return a new unit vector
function _turtle3d_xu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_unit_vts(turtle)[0], 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], cosa), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], sina)
            ), 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[1]), sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _turtle3d_yu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], cosa), 
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[2]), sina)
            ),
            _turtle3d_unit_vts(turtle)[1], 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _turtle3d_zu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], cosa), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], sina)
            ),
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[0]), sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], cosa)
            ),
            _turtle3d_unit_vts(turtle)[2], 
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