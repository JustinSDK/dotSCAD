/**
* parse_number.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-parse_number.html
*
**/ 
    
function _str_to_int(t, i = 0, mapper = [["0", 0], ["1", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9]]) =  
    i == len(mapper) ? -1 : (
        mapper[i][0] == t ? mapper[i][1] : _str_to_int(t, i + 1)
    );
    
function _parse_positive_int(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_int(t, value * pow(10, i) + _str_to_int(t[i]), i + 1);

function _parse_positive_decimal(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_decimal(t, value + _str_to_int(t[i]) * pow(10, -(i + 1)), i + 1);
    
function _parse_positive_number(t) =
    len(search(".", t)) == 0 ? _parse_positive_int(t) :
        _parse_positive_int(split_str(t, ".")[0]) + _parse_positive_decimal(split_str(t, ".")[1]);
         
function parse_number(t) = 
    t[0] == "-" ? -_parse_positive_number(sub_str(t, 1, len(t))) : _parse_positive_number(t);

