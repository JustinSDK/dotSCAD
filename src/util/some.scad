function _some(dest, assert_func, leng, i = 0) = 
    i == leng ? false :
        assert_func(dest[i]) ? true : _some(dest, assert_func, leng, i + 1);

function some(dest, assert_func) = _some(dest, assert_func, len(dest));