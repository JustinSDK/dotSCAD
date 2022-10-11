to_do:


new:

- surface/sf_cylinder?
- noise/worley_sphere?
- voronoi/vrn_sphere?
- polyline_join: doc multi-childs

- lemniscate_curve?
- perlin_sphere?

doc-ed

    deprecated:
    - util/sort, util/bsearch, util/has
    - pp/pp_disk, pp/pp_sphere, pp_poisson2, pp_poisson3
    - maze/mz_square_cells, maze/mz_theta_cells, maze/mz_square_walls, maze/mz_hex_walls
    - rails2sections

    new:
    - util/sorted, util/binary_search, util/contains
    - maze/mz_square, maze/mz_theta, maze/mz_squarewalls, maze/mz_hexwalls, maze/mz_tiles
    - matrix/m_replace
    - triangle/tri_subdivide

    - lsystem2, lsystem3, add seed param
    - t3d - roll/pitch/turn/forward
    - sf, stereographic_extrude add convexity
    - mz_hamiltonian supports init_cells