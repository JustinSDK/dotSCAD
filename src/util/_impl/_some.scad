function _some(lt, assert_func, leng, i = 0) = 
    i == leng ? false :
        assert_func(lt[i]) ? true : _some(lt, assert_func, leng, i + 1);