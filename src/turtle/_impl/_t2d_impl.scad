function _turtle(point, angle) = 
    [is_undef(point) ? [0, 0] : point, is_undef(angle) ? 0 : angle];

function _set_point(t, point) = [point, _get_angle(t)];

function _set_x(t, x) = [[x, _get_y(t)], _get_angle(t)];
function _set_y(t, y) = [[_get_x(t), y], _get_angle(t)];
function _set_angle(t, angle) = [_get_pt(t), angle];

function _forward(t, leng) = 
    _turtle(
        [
            _get_x(t) + leng * cos(_get_angle(t)), 
            _get_y(t) + leng * sin(_get_angle(t))
        ], 
        _get_angle(t)
    );

function _turn(t, angle) = [_get_pt(t), _get_angle(t) + angle];

function _get_x(t) = t[0].x;
function _get_y(t) = t[0].y;
function _get_pt(t) = t[0];
function _get_angle(t) = t[1];

function _get(t, cmd) =
    cmd == "angle" ? _get_angle(t) : 
    cmd == "point" ? _get_pt(t) : 
    assert(false, "unknown command");

function _set(t, point, angle) =
    !is_undef(point) ? _set_point(t, point) :
    !is_undef(angle) ? _set_angle(t, angle) :
    assert(false, "no target to set");

function _cmdline(cmd, t, arg) = 
    is_undef(arg) ? _get(t, cmd) : 
    cmd == "forward" ? _forward(t, arg) : 
    cmd == "turn" ? _turn(t, arg) :
    cmd == "point" ? _set_point(t, arg) : 
    cmd == "angle" ? _set_angle(t, arg) :  
    assert(false, "unknown command");

function _cmd(t, cmd, point, angle, leng) = 
    cmd == "forward" ? _forward(t, leng) :
    cmd == "turn" ? _turn(t, angle) :
    _get(t, cmd);

function _cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _cmds(_cmdline(cmd, t, arg), cmds, i + 1);

function _t2d_impl(t, cmd, point, angle, leng) =
    is_undef(t) ? _turtle(point, angle) : 
    is_undef(cmd) ? _set(t, point, angle) :
    is_string(cmd) ? _cmd(t, cmd, point, angle, leng) :
                     _cmds(t, cmd);