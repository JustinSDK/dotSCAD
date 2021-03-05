function find_index(lt, test) = _find_index(lt, test, len(lt));

function _find_index(lt, test, leng, i = 0) =
    i == leng ? -1 :
    test(lt[i]) ? i : _find_index(lt, test, leng, i + 1);