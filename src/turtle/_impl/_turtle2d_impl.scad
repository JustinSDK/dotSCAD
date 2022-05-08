function _turtle(x, y, angle) = [[x, y], angle];

function _set_point(turtle, point) = [point, _get_angle(turtle)];

function _set_x(turtle, x) = [[x, _get_y(turtle)], _get_angle(turtle)];
function _set_y(turtle, y) = [[_get_x(turtle), y], _get_angle(turtle)];
function _set_angle(turtle, angle) = [_get_pt(turtle), angle];

function _forward(turtle, leng) = 
    _turtle(
        _get_x(turtle) + leng * cos(_get_angle(turtle)), 
        _get_y(turtle) + leng * sin(_get_angle(turtle)), 
        _get_angle(turtle)
    );

function _turn(turtle, angle) = [_get_pt(turtle), _get_angle(turtle) + angle];

function _get_x(turtle) = turtle[0].x;
function _get_y(turtle) = turtle[0].y;
function _get_pt(turtle) = turtle[0];
function _get_angle(turtle) = turtle[1];

function _three_args_command(cmd, arg1, arg2, arg3) = 
    cmd == "create" ? _turtle(arg1, arg2, arg3) : _two_args_command(cmd, arg1, arg2);

function _two_args_command(cmd, arg1, arg2) =
    is_undef(arg2) ? _one_arg_command(cmd, arg1) : 
    cmd == "pt" ? _set_point(arg1, arg2) : 
    cmd == "x" ? _set_x(arg1, arg2) : 
    cmd == "y" ? _set_y(arg1, arg2) : 
    cmd == "angle" ? _set_angle(arg1, arg2) : 
    cmd == "forward" ? _forward(arg1, arg2) : 
    cmd == "turn" ? _turn(arg1, arg2) : undef;
    
function _one_arg_command(cmd, arg) =
    cmd == "x" ? _get_x(arg) : 
    cmd == "y" ? _get_y(arg) : 
    cmd == "angle" ? _get_angle(arg) : 
    cmd == "pt" ? _get_pt(arg) : undef;

function _turtle2d_impl(cmd, arg1, arg2, arg3) = 
    _three_args_command(cmd, arg1, arg2, arg3);
