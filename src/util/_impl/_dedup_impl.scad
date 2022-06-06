use <../some.scad>

function _dedup(elems, leng, buckets, eq, hash, bucket_numbers) = 
    let(
        end = leng - 1,
        _dedup_add = is_undef(eq) ? _dedup_add_search : _dedup_add_some,
        n_buckets_lt = [
        for(i = 0, n_buckets = _dedup_add(buckets, [i, elems[i]], eq, hash, bucket_numbers), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _dedup_add(n_buckets, [i, elems[i]], eq, hash, bucket_numbers) : undef) 
            n_buckets
        ]
    )
    _dedup_add(n_buckets_lt[end - 1], [end, elems[end]], eq, hash, bucket_numbers); 

_dedup_add_some = function(buckets, i_elem, eq, hash, bucket_numbers)
    let(
		elem = i_elem[1],
	    b_idx = hash(elem) % bucket_numbers,
		bucket = buckets[b_idx]
	)
    some(bucket, function(i_e) eq(i_e[1], elem)) ? buckets : _add(buckets, bucket, i_elem, b_idx);

_dedup_add_search = function(buckets, i_elem, eq, hash, bucket_numbers) 
    let(
		elem = i_elem[1],
	    b_idx = hash(elem) % bucket_numbers,
		bucket = buckets[b_idx]
	)
    search([elem], bucket, num_returns_per_match = 1, index_col_num = 1) != [[]] ? buckets : _add(buckets, bucket, i_elem, b_idx);

function _add(buckets, bucket, i_elem, b_idx) = 
    let(leng = len(buckets))
	[for(i = 0; i < leng; i = i + 1) i == b_idx ? [each bucket, i_elem] : buckets[i]];

function before_after(lt, pivot, leng, before = [], after = [], j = 1) =
    j == leng ? [before, after] :
    let(is_less = lt[j][0] < pivot[0])
    before_after(lt, pivot, leng,
         is_less ? [each before, lt[j]] : before, 
         is_less ? after : [each after, lt[j]], 
         j + 1
    );

function _sort(lt) = 
    let(leng = len(lt))
	leng == 0 ? [] :
	leng == 1 ? [lt[0][1]] :
	let(
		pivot = lt[0],
		b_a = before_after(lt, pivot, leng)
	)
	[each _sort(b_a[0]), pivot[1], each _sort(b_a[1])];