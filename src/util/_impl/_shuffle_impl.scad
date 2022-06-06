use <../swap.scad>

function _shuffle(lt, indices, leng) =
    let(end = len(lt) - 1)
    end == 0 ? lt :
    let(
        cum = [
            for(i = 0, s = swap(lt, 0, indices[0]), is_continue = i < end; 
                is_continue; 
                i = i + 1, is_continue = i < end, s = is_continue ? swap(s, i, indices[i]) : undef) s]
    )
    swap(cum[end - 1], end, indices[end]);