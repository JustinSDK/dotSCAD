function _some(lt, test, leng, i = 0) = 
    i == leng ? false :
        test(lt[i]) ? true : _some(lt, test, leng, i + 1);