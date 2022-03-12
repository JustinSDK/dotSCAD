use <../util/sum.scad>;

function _str_hash(value) = 
    let(
		chars = str(value),
		end = len(chars) - 1
	)
	end == 0 ? ord(chars[0]) :
	let(cum_total = [for(i = 0, s = ord(chars[i]); i < end; i = i + 1, s = s + (ord(chars[i]) * 31 ^ i)) s])
	cum_total[len(cum_total) - 1] + (ord(chars[end]) * 31 ^ i);

	// sum([
	// 	for(i = len(s) - 1; i > -1; i = i - 1)
	// 	ord(s[i]) * 31 ^ i
	// ]);

    let(end = len(lt) - 1)
    end == 0 ? lt[0] :
    let(cum_total = [for(i = 0, s = lt[0]; i < end; i = i + 1, s = s + lt[i]) s])
    cum_total[len(cum_total) - 1] + lt[end];