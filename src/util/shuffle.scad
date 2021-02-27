use <swap.scad>;

function shuffle(lt, seed) = 
    let(
        leng = len(lt),
        indices = [for(i = is_undef(seed) ? rands(0, leng, leng) : rands(0, leng, leng, seed)) floor(i)]
    )
    _shuffle(lt, indices, leng);

function _shuffle(lt, indices, leng, i = 0) =
    i == leng ? lt : _shuffle(swap(lt, i, indices[i]), indices, leng, i + 1);