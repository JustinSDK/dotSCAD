/**
* turtle2d.scad
*
* An OpenSCAD implementation of Turtle Graphics. 
* It moves on the xy plane. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-turtle2d.html
*
**/ 

include <line2d.scad>;

function _turtle2d_turtle(x, y, angle) = [[x, y], angle];

function _turtle2d_set_point(turtle, point) = [point, _turtle2d_get_angle(turtle)];

function _turtle2d_set_x(turtle, x) = [[x, _turtle2d_get_y(turtle)], _turtle2d_get_angle(turtle)];
function _turtle2d_set_y(turtle, y) = [[_turtle2d_get_x(turtle), y], _turtle2d_get_angle(turtle)];
function _turtle2d_set_angle(turtle, angle) = [_turtle2d_get_pt(turtle), angle];

function _turtle2d_forward(turtle, leng) = 
    _turtle2d_turtle(
        _turtle2d_get_x(turtle) + leng * cos(_turtle2d_get_angle(turtle)), 
        _turtle2d_get_y(turtle) + leng * sin(_turtle2d_get_angle(turtle)), 
        _turtle2d_get_angle(turtle)
    );

function _turtle2d_turn(turtle, angle) = [_turtle2d_get_pt(turtle), _turtle2d_get_angle(turtle) + angle];

function _turtle2d_get_x(turtle) = turtle[0][0];
function _turtle2d_get_y(turtle) = turtle[0][1];
function _turtle2d_get_pt(turtle) = turtle[0];
function _turtle2d_get_angle(turtle) = turtle[1];

function _turtle2d_three_args_command(cmd, arg1, arg2, arg3) = 
    cmd == "create" ? _turtle2d_turtle(arg1, arg2, arg3) : _turtle2d_two_args_command(cmd, arg1, arg2);

function _turtle2d_two_args_command(cmd, arg1, arg2) =
    cmd == "set_pt" ? _turtle2d_set_point(arg1, arg2) : (
        cmd == "set_x" ? _turtle2d_set_x(arg1, arg2) : (
            cmd == "set_y" ? _turtle2d_set_y(arg1, arg2) : (
                cmd == "set_a" ? _turtle2d_set_angle(arg1, arg2) : (
                    cmd == "forward" ? _turtle2d_forward(arg1, arg2) : (
                        cmd == "turn" ? _turtle2d_turn(arg1, arg2) : _turtle2d_one_arg_command(cmd, arg1)
                    )
                )
            )
        )
    );
    
function _turtle2d_one_arg_command(cmd, arg) =
    cmd == "get_x" ? _turtle2d_get_x(arg) : (
        cmd == "get_y" ? _turtle2d_get_y(arg) : (
            cmd == "get_a" ? _turtle2d_get_angle(arg) : (
                cmd == "get_pt" ? _turtle2d_get_pt(arg) : undef
            )
        )
    );

function turtle2d(cmd, arg1, arg2, arg3) = 
    _turtle2d_three_args_command(cmd, arg1, arg2, arg3);
