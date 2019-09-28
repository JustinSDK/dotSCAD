/**
* turtle2d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-t2d.html
*
**/ 

function _t2d_turtle(point, angle) = [point, angle];

function _t2d_set_point(turtle, point) = [point, _t2d_get_angle(turtle)];

function _t2d_set_x(turtle, x) = [[x, _t2d_get_y(turtle)], _t2d_get_angle(turtle)];
function _t2d_set_y(turtle, y) = [[_t2d_get_x(turtle), y], _t2d_get_angle(turtle)];
function _t2d_set_angle(turtle, angle) = [_t2d_get_pt(turtle), angle];

function _t2d_forward(turtle, leng) = 
    _t2d_turtle(
        [
            _t2d_get_x(turtle) + leng * cos(_t2d_get_angle(turtle)), 
            _t2d_get_y(turtle) + leng * sin(_t2d_get_angle(turtle))
        ], 
        _t2d_get_angle(turtle)
    );

function _t2d_turn(turtle, angle) = [_t2d_get_pt(turtle), _t2d_get_angle(turtle) + angle];

function _t2d_get_x(turtle) = turtle[0][0];
function _t2d_get_y(turtle) = turtle[0][1];
function _t2d_get_pt(turtle) = turtle[0];
function _t2d_get_angle(turtle) = turtle[1];

function _t2d_two_args_command(cmd, arg1, arg2) =
    is_undef(arg2) ? _t2d_one_arg_command(cmd, arg1) : 
    cmd == "point" ? _t2d_set_point(arg1, arg2) : 
    cmd == "x" ? _t2d_set_x(arg1, arg2) : 
    cmd == "y" ? _t2d_set_y(arg1, arg2) : 
    cmd == "angle" ? _t2d_set_angle(arg1, arg2) : 
    cmd == "forward" ? _t2d_forward(arg1, arg2) : 
    cmd == "turn" ? _t2d_turn(arg1, arg2) : assert(false, "unknown command");
    
function _t2d_one_arg_command(cmd, arg) =
    cmd == "x" ? _t2d_get_x(arg) : 
    cmd == "y" ? _t2d_get_y(arg) : 
    cmd == "angle" ? _t2d_get_angle(arg) : 
    cmd == "point" ? _t2d_get_pt(arg) : assert(false, "unknown command");

function _t2d_cmdline(cmd, arg1, arg2) = 
     _t2d_two_args_command(cmd, arg1, arg2);

function _t2d_set(t, point, angle, x, y) =
    !is_undef(point) ? _t2d_set_point(t, point) :
    !is_undef(angle) ? _t2d_set_angle(t, angle) :
    !is_undef(x) ? _t2d_set_x(t, x) :
    !is_undef(y) ? _t2d_set_y(t, y) : 
    assert(false, "no target to set");

function _t2d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t2d_cmds(_t2d_cmdline(cmd, t, arg), cmds, i + 1);

function t2d(t, cmd, cmds, point, angle, x, y, leng) =
    is_undef(t) ? _t2d_turtle(point, angle) : 
    cmd == "set" ? _t2d_set(t, point, angle, x, y) :
    cmd == "forward" ? _t2d_forward(t, leng) :
    cmd == "turn" ? _t2d_turn(t, angle) :
    cmd == "point" ? _t2d_get_pt(t) :
    cmd == "angle" ? _t2d_get_angle(t) :
    cmd == "x" ? _t2d_get_x(t) :
    cmd == "y" ? _t2d_get_y(t) :
    !is_undef(cmds) ? _t2d_cmds(t, cmds) :
    assert(false, "unknown command");