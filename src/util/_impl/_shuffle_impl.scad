use <../swap.scad>;

function _shuffle(lt, indices, leng) =
    let(end = len(lt) - 1)
    end == 0 ? lt :
    let(cum = [for(i = 0, s = swap(lt, i, indices[i]); i < end; i = i + 1, s = swap(s, i, indices[i])) s])
    swap(cum[len(cum) - 1], end, indices[end]);