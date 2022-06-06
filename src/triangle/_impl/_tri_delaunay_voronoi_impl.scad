use <../../util/map/hashmap_get.scad>

function indicesOfCell(iTris, triIndices) = 
    let(leng = len(iTris))
    [
		for(i = 0, vi = iTris[0][0], t = iTris[search([vi], iTris)[0]]; 
		    i < leng;
			i = i + 1,
			vi = t[1],
			t = i < leng ? iTris[search([vi], iTris)[0]] : undef) 
		hashmap_get(triIndices, t)
	];
