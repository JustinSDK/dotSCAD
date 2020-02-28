function _sum_impl(lt, leng, i = 0) =
    i >= leng - 1 ? lt[i] : (lt[i] + _sum_impl(lt, leng, i + 1));
