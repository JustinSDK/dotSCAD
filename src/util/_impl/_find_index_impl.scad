function _find_index(lt, test, leng, i = 0) =
    i == leng ? -1 :
    test(lt[i]) ? i : _find_index(lt, test, leng, i + 1);