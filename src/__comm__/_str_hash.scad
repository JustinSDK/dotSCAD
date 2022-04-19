_str_hash = function(value)
    let(
		chars = str(value),
		end = len(chars) - 1
	)
	end == 0 ? ord(chars[0]) :
	let(
		cum_total = [
			for(i = 0, s = ord(chars[0]), is_continue = i < end; 
			    is_continue; 
				i = i + 1, is_continue = i < end,  s = is_continue ? 31 * s + ord(chars[i]) : undef) s]
	)
	31 * cum_total[end - 1] + ord(chars[end]);