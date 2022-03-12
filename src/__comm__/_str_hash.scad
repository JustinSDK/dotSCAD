function _str_hash(value) = 
    let(
		chars = str(value),
		end = len(chars) - 1
	)
	end == 0 ? ord(chars[0]) :
	let(cum_total = [for(i = 0, s = ord(chars[0]); i < end; i = i + 1, s = s + (ord(chars[i]) * 31 ^ i)) s])
	cum_total[end - 1] + (ord(chars[end]) * 31 ^ end);
