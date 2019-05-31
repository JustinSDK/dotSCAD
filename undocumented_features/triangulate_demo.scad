include <triangulate.scad>; 

shape = [
    [0, 0],
    [10, 0],
    [12, 5],
    [5, 10],
    [10, 15],
    [0, 20],
    [-5, 18],
    [-8, 3],
    [-4, 10]
];

tris = triangulate(shape);

polygon(shape);
for(tri = tris) {
    #offset(-.1) 
        polygon([for(idx = tri) shape[idx]]);
    
}