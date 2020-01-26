use <util/sub_str.scad>;
use <util/split_str.scad>;

function _str_to_int(t) =  ord(t) - 48;
    
function _parse_positive_int(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_int(t, value * pow(10, i) + _str_to_int(t[i]), i + 1);

function _parse_positive_decimal(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_decimal(t, value + _str_to_int(t[i]) * pow(10, -(i + 1)), i + 1);
    
function _parse_positive_number(t) =
    len(search(".", t)) == 0 ? _parse_positive_int(t) :
        _parse_positive_int(split_str(t, ".")[0]) + _parse_positive_decimal(split_str(t, ".")[1]);
         
function _parse_number_impl(t) = 
    t[0] == "-" ? -_parse_positive_number(sub_str(t, 1, len(t))) : _parse_positive_number(t);

