use <../sub_str.scad>
use <../split_str.scad>

function _str_to_int(t) =  ord(t) - 48;
    
function _parse_positive_int(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_int(t, value * 10 + _str_to_int(t[i]), i + 1);

function _parse_positive_number(t) =
    len(search(".", t)) == 0 ? _parse_positive_int(t) :
        let(splitted = split_str(t, "."))
        _parse_positive_int(splitted[0]) + _parse_positive_int(splitted[1]) / 10 ^ (len(splitted[1]));
         
function _parse_number_impl(t) = 
    t[0] == "-" ? -_parse_positive_number(sub_str(t, 1, len(t))) : _parse_positive_number(t);

