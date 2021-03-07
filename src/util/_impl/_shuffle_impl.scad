use <../swap.scad>;

function _shuffle(lt, indices, leng, i = 0) =
    i == leng ? lt : _shuffle(swap(lt, i, indices[i]), indices, leng, i + 1);