function before_after(lt, pivot, less, leng, before = [], after = [], j = 1) =
    j == leng ? [before, after] :
    let(is_less = less(lt[j], pivot))
    before_after(lt, pivot, less, leng,
         is_less ? [each before, lt[j]] : before, 
         is_less ? after : [each after, lt[j]], 
         j + 1
    );

function _sorted(lt, less) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
    leng == 2 ? !less(lt[1], lt[0]) ? lt : [lt[1], lt[0]] :
        let(
            pivot = lt[0],
            b_a = before_after(lt, pivot, less, leng)
        )
        [each _sorted(b_a[0], less), pivot, each _sorted(b_a[1], less)];

function _sorted_default(lt) = _sorted(lt, function(a, b) a < b);

function _sorted_cmp(lt, cmp) = _sorted(lt, function(a, b) cmp(a, b) < 0);   