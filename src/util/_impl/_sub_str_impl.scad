function _sub_str(t, begin, end) = 
    begin == end ? "" : str(t[begin], _sub_str_impl(t, begin + 1, end));
    
function _sub_str_impl(t, begin, end) = 
    is_undef(end) ? _sub_str(t, begin, len(t)) : _sub_str(t, begin, end);
