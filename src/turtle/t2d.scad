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

function _t2d_set_point(t, point) = [point, _t2d_get_angle(t)];

function _t2d_set_x(t, x) = [[x, _t2d_get_y(t)], _t2d_get_angle(t)];
function _t2d_set_y(t, y) = [[_t2d_get_x(t), y], _t2d_get_angle(t)];
function _t2d_set_angle(t, angle) = [_t2d_get_pt(t), angle];

function _t2d_forward(t, leng) = 
    _t2d_turtle(
        [
            _t2d_get_x(t) + leng * cos(_t2d_get_angle(t)), 
            _t2d_get_y(t) + leng * sin(_t2d_get_angle(t))
        ], 
        _t2d_get_angle(t)
    );

function _t2d_turn(t, angle) = [_t2d_get_pt(t), _t2d_get_angle(t) + angle];

function _t2d_get_x(t) = t[0][0];
function _t2d_get_y(t) = t[0][1];
function _t2d_get_pt(t) = t[0];
function _t2d_get_angle(t) = t[1];

function _t2d_two_args_command(cmd, t, arg) =
    is_undef(arg) ? _t2d_one_arg_command(cmd, t) : 
    cmd == "point" ? _t2d_set_point(t, arg) : 
    cmd == "x" ? _t2d_set_x(t, arg) : 
    cmd == "y" ? _t2d_set_y(t, arg) : 
    cmd == "angle" ? _t2d_set_angle(t, arg) : 
    cmd == "forward" ? _t2d_forward(t, arg) : 
    cmd == "turn" ? _t2d_turn(t, arg) : assert(false, "unknown command");
    
function _t2d_one_arg_command(cmd, t) =
    cmd == "x" ? _t2d_get_x(t) : 
    cmd == "y" ? _t2d_get_y(t) : 
    cmd == "angle" ? _t2d_get_angle(t) : 
    cmd == "point" ? _t2d_get_pt(t) : assert(false, "unknown command");

function _t2d_cmdline(cmd, t, arg) = 
     _t2d_two_args_command(cmd, t, arg);

function _t2d_set(t, point, angle, x, y) =
    !is_undef(point) ? _t2d_set_point(t, point) :
    !is_undef(angle) ? _t2d_set_angle(t, angle) :
    !is_undef(x) ? _t2d_set_x(t, x) :
    !is_undef(y) ? _t2d_set_y(t, y) : 
    assert(false, "no target to set");

function _t2d_cmd(t, cmd, point, angle, x, y, leng) = 
    cmd == "set" ? _t2d_set(t, point, angle, x, y) :
    cmd == "forward" ? _t2d_forward(t, leng) :
    cmd == "turn" ? _t2d_turn(t, angle) :
    cmd == "point" ? _t2d_get_pt(t) :
    cmd == "angle" ? _t2d_get_angle(t) :
    cmd == "x" ? _t2d_get_x(t) :
    cmd == "y" ? _t2d_get_y(t) : assert(false, "unknown command");

function _t2d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t2d_cmds(_t2d_cmdline(cmd, t, arg), cmds, i + 1);

function t2d(t, cmd, point, angle, x, y, leng) =
    is_undef(t) ? _t2d_turtle(point, angle) : 
    is_string(cmd) ? _t2d_cmd(t, cmd, point, angle, x, y, leng) :
                     _t2d_cmds(t, cmd) ;