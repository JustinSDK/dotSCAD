use <experimental/_impl/_nz_cells_impl.scad>;
    
function nz_cells(cells, p, dist = "euclidean") =
    dist == "border" ? _nz_cells_border(cells, p) :
                       _nz_cells_classic(cells, p, dist); 