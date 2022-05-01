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
    leng == 2 ? less(lt[0], lt[1]) ? elems(lt, elem) : [elem(lt[1]), elem(lt[0])] :
        let(
            pivot = lt[0],
            b_a = before_after(lt, pivot, less, leng)
        )
        [each _sorted(b_a[0], less, elem), elem(pivot), each _sorted(b_a[1], less, elem)];

function _sorted_default(lt, reverse) = _sorted(lt, reverse ? function(a, b) a > b : function(a, b) a < b);

function _sorted_cmp(lt, cmp, reverse) = _sorted(lt, reverse ? function(a, b) cmp(a, b) > 0 : function(a, b) cmp(a, b) < 0);   

function _sorted_key(lt, key, reverse) =
    let(key_elem_lt = [for(elem = lt) [key(elem), elem]])  
    _sorted(key_elem_lt, reverse ? function(a, b) a[0] > b[0] : function(a, b) a[0] < b[0], function(elem) elem[1]);