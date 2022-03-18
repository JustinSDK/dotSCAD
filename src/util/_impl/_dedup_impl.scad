use <../some.scad>;

function _dedup(elems, leng, buckets, eq, hash, bucket_numbers) = 
    let(
        end = leng - 1,
        n_buckets_lt = [
        for(i = 0, n_buckets = _dedup_add(buckets, [i, elems[i]], eq, hash, bucket_numbers), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _dedup_add(n_buckets, [i, elems[i]], eq, hash, bucket_numbers) : undef) 
            n_buckets
        ]
    )
    _dedup_add(n_buckets_lt[end - 1], [end, elems[end]], eq, hash, bucket_numbers); 


function _dedup_add(buckets, i_elem, eq, hash, bucket_numbers) =
    let(
		elem = i_elem[1],
	    b_idx = hash(elem) % bucket_numbers,
		bucket = buckets[b_idx]
	)
	some(bucket, function(i_e) eq(i_e[1], elem)) ? buckets : _add(buckets, bucket, i_elem, b_idx);

function _add(buckets, bucket, i_elem, b_idx) = 
    let(leng = len(buckets))
	[for(i = 0; i < leng; i = i + 1) i == b_idx ? [each bucket, i_elem] : buckets[i]];