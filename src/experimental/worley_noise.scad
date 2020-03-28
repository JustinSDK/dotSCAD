use <experimental/_impl/_worley_noise_impl.scad>;

function worley_noise(p, points, dist = "euclidean") =
    let(
        dists = dist == "euclidean" ? [for(i = [0:len(points) - 1]) norm(points[i] - p)] :
                dist == "manhattan" ? [for(i = [0:len(points) - 1]) _manhattan(points[i] - p)] :
                dist == "chebyshev" ? [for(i = [0:len(points) - 1]) _chebyshev(points[i], p)] : 
                                      assert("Unknown distance option")
    )
    min(dists);