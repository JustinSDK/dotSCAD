function swap(lt, i, j) =
    i == j ? lt :
    let(
	    leng = len(lt),
		a = min([i, j]),
		b = max([i, j])
	)
    concat(
	    a == 0 ? [] : [for(idx = [0:a - 1]) lt[idx]], 
		[lt[b]], 
		b - a == 1? [] : [for(idx = [a + 1:b - 1]) lt[idx]], 
		[lt[a]], 
		b == leng - 1 ? [] : [for(idx = [b + 1:leng - 1]) lt[idx]]
	);