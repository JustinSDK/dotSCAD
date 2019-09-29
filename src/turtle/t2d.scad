/**
* t2d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-t2d.html
*
**/ 

function _t2d_turtle(point, angle) = 
    [is_undef(point) ? [0, 0] : point, is_undef(angle) ? 0 : angle];

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

function _t2d_get(t, cmd) =
    cmd == "angle" ? _t2d_get_angle(t) : 
    cmd == "point" ? _t2d_get_pt(t) : 
    assert(false, "unknown command");

function _t2d_set(t, point, angle) =
    !is_undef(point) ? _t2d_set_point(t, point) :
    !is_undef(angle) ? _t2d_set_angle(t, angle) :
    assert(false, "no target to set");

function _t2d_cmdline(cmd, t, arg) = 
    is_undef(arg) ? _t2d_get(t, cmd) : 
    cmd == "forward" ? _t2d_forward(t, arg) : 
    cmd == "turn" ? _t2d_turn(t, arg) :
    cmd == "point" ? _t2d_set_point(t, arg) : 
    cmd == "angle" ? _t2d_set_angle(t, arg) :  
    assert(false, "unknown command");

function _t2d_cmd(t, cmd, point, angle, leng) = 
    cmd == "forward" ? _t2d_forward(t, leng) :
    cmd == "turn" ? _t2d_turn(t, angle) :
    _t2d_get(t, cmd);

function _t2d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t2d_cmds(_t2d_cmdline(cmd, t, arg), cmds, i + 1);

function t2d(t, cmd, point, angle, leng) =
    is_undef(t) ? _t2d_turtle(point, angle) : 
    is_undef(cmd) ? _t2d_set(t, point, angle) :
    is_string(cmd) ? _t2d_cmd(t, cmd, point, angle, leng) :
                     _t2d_cmds(t, cmd) ;