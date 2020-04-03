use <noise/_impl/_nz_cell_impl.scad>;
    
function nz_cell(points, p, dist = "euclidean") =
    dist == "border" ? _nz_cell_border(points, p) :
                       _nz_cell_classic(points, p, dist); 