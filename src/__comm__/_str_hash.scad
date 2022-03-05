use <../util/sum.scad>;

function _str_hash(value) = 
    let(s = str(value))
	sum([
		for(i = len(s) - 1; i > -1; i = i - 1)
		ord(s[i]) * 31 ^ i
	]);