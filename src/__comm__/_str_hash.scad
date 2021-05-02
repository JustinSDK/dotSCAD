use <../util/sum.scad>;

function _str_hash(value) = 
    let(
	    s = str(value),
		leng = len(s)
	)
	sum([
	    for(i = [0:leng - 1])
		ord(s[i]) * 31 ^ (leng - 1 - i)
	]);