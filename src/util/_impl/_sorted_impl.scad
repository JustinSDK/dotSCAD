function before_after(lt, pivot, less, leng, before = [], after = [], j = 1) =
    j == leng ? [before, after] :
    let(is_less = less(lt[j], pivot))
    before_after(lt, pivot, less, leng,
         is_less ? [each before, lt[j]] : before, 
         is_less ? after : [each after, lt[j]], 
         j + 1
    );

identity = function(elem) elem;

function elems(lt, elem) = [for(e = lt) elem(e)];

function _sorted(lt, less, elem = identity) = 
    let(leng = len(lt))
    leng <= 1 ? elems(lt, elem) : 
    leng == 2 ? !less(lt[1], lt[0]) ? elems(lt, elem) : elems([lt[1], lt[0]], elem) :
        let(
            pivot = lt[0],
            b_a = before_after(lt, pivot, less, leng)
        )
        [each _sorted(b_a[0], less, elem), elem(pivot), each _sorted(b_a[1], less, elem)];

function _sorted_default(lt) = _sorted(lt, function(a, b) a < b);

function _sorted_cmp(lt, cmp) = _sorted(lt, function(a, b) cmp(a, b) < 0);   

function _sorted_key(lt, key) =
    let(key_elem_lt = [for(elem = lt) [key(elem), elem]])  
    _sorted(key_elem_lt, function(a, b) a[0] < b[0], function(elem) elem[1]);