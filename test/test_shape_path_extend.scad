include <unittest.scad>;

include <rotate_p.scad>;
include <shape_path_extend.scad>;
include <circle_path.scad>;
include <archimedean_spiral.scad>;

$fn = 96;

module test_shape_path_extend_stroke1() {
    echo("==== test_shape_path_extend_stroke1 ====");

    stroke1 = [[-5, 2.5], [-2.5, 0], [0, 2.5], [2.5, 0], [5, 2.5]];
    path_pts1 = circle_path(50, 60);
    
    expected = [[44.9209, 2.3351], [47.5013, -0.0818], [49.9182, 2.4987], [52.4987, 0.0818], [54.9155, 2.6623], [54.8085, 5.9324], [54.3031, 9.5044], [53.5652, 13.0356], [52.598, 16.511], [51.4055, 19.9157], [49.9929, 23.2352], [48.3662, 26.4551], [46.5324, 29.5618], [44.4993, 32.5419], [42.2757, 35.3826], [39.8711, 38.0718], [37.2957, 40.598], [34.5606, 42.9503], [31.6775, 45.1187], [28.6588, 47.0939], [25.5173, 48.8675], [22.2666, 50.4317], [18.9205, 51.7801], [15.4935, 52.9067], [12, 53.8067], [8.4552, 54.4763], [4.8742, 54.9127], [1.2723, 55.1139], [-2.3351, 55.0791], [-5.9324, 54.8085], [-9.5044, 54.3031], [-13.0356, 53.5652], [-16.511, 52.598], [-19.9157, 51.4055], [-23.2352, 49.9929], [-26.4551, 48.3662], [-29.5618, 46.5324], [-32.5419, 44.4993], [-35.3826, 42.2757], [-38.0718, 39.8711], [-40.598, 37.2957], [-42.9503, 34.5606], [-45.1187, 31.6775], [-47.0939, 28.6588], [-48.8675, 25.5173], [-50.4317, 22.2666], [-51.7801, 18.9205], [-52.9067, 15.4935], [-53.8067, 12], [-54.4763, 8.4552], [-54.9127, 4.8742], [-55.1139, 1.2723], [-55.0791, -2.3351], [-54.8085, -5.9324], [-54.3031, -9.5044], [-53.5652, -13.0356], [-52.598, -16.511], [-51.4055, -19.9157], [-49.9929, -23.2352], [-48.3662, -26.4551], [-46.5324, -29.5618], [-44.4993, -32.5419], [-42.2757, -35.3826], [-39.8711, -38.0718], [-39.5245, -34.5533], [-36.006, -34.8998], [-35.6595, -31.3813], [-32.141, -31.7279], [-32.141, -31.7279], [-34.1472, -29.5578], [-36.0073, -27.2612], [-37.7132, -24.8478], [-39.2576, -22.3281], [-40.6338, -19.7127], [-41.8361, -17.0129], [-42.8592, -14.2403], [-43.6988, -11.4066], [-44.3513, -8.5242], [-44.8138, -5.6052], [-45.0845, -2.6623], [-45.1621, 0.2921], [-45.0463, 3.2452], [-44.7376, 6.1844], [-44.2373, 9.0972], [-43.5476, 11.971], [-42.6714, 14.7935], [-41.6125, 17.5526], [-40.3754, 20.2367], [-38.9654, 22.834], [-37.3886, 25.3336], [-35.6517, 27.7247], [-33.762, 29.997], [-31.7279, 32.141], [-29.5578, 34.1472], [-27.2612, 36.0073], [-24.8478, 37.7132], [-22.3281, 39.2576], [-19.7127, 40.6338], [-17.0129, 41.8361], [-14.2403, 42.8592], [-11.4066, 43.6988], [-8.5242, 44.3513], [-5.6052, 44.8138], [-2.6623, 45.0845], [0.2921, 45.1621], [3.2452, 45.0463], [6.1844, 44.7376], [9.0972, 44.2373], [11.971, 43.5476], [14.7935, 42.6714], [17.5526, 41.6125], [20.2367, 40.3754], [22.834, 38.9654], [25.3336, 37.3886], [27.7247, 35.6517], [29.997, 33.762], [32.141, 31.7279], [34.1472, 29.5578], [36.0073, 27.2612], [37.7132, 24.8478], [39.2576, 22.3281], [40.6338, 19.7127], [41.8361, 17.0129], [42.8592, 14.2403], [43.6988, 11.4066], [44.3513, 8.5242]];
    
    actual = shape_path_extend(stroke1, path_pts1);
    
    assertEqualPoints(expected, actual);   
}

module test_shape_path_extend_stroke2() {
    echo("==== test_shape_path_extend_stroke2 ====");

    stroke2 = [[-4, 0], [0, 4], [4, 0]];
    pts_angles = archimedean_spiral(
        arm_distance = 17,
        init_angle = 180,
        point_distance = 5,
        num_of_points = 85 
    ); 
    
    expected = [[-4.5011, 0.0947], [-8.4053, -3.9989], [-12.4989, -0.0947], [-12.3643, -5.7817], [-8.5243, -12.4798], [-2.2566, -16.2117], [4.7338, -16.8348], [11.2185, -14.7228], [16.3807, -10.5003], [19.7496, -4.8836], [21.1346, 1.4176], [20.5617, 7.7614], [18.2156, 13.6081], [14.389, 18.5362], [9.4388, 22.2465], [3.7507, 24.5569], [-2.2893, 25.3921], [-8.317, 24.7693], [-14.0056, 22.7825], [-19.0767, 19.5862], [-23.3068, 15.3794], [-26.5297, 10.3903], [-28.6366, 4.8631], [-29.5737, -0.9545], [-29.3373, -6.8213], [-27.9691, -12.511], [-25.5494, -17.819], [-22.1903, -22.5671], [-18.0291, -26.6074], [-13.221, -29.8235], [-7.9329, -32.1319], [-2.3372, -33.4815], [3.394, -33.8522], [9.0933, -33.2528], [14.6026, -31.7189], [19.7766, -29.3093], [24.4855, -26.1033], [28.6173, -22.1964], [32.0793, -17.6978], [34.7988, -12.726], [36.7237, -7.4055], [37.8222, -1.8642], [38.0821, 3.7706], [37.5103, 9.3741], [36.1309, 14.8272], [33.984, 20.018], [31.124, 24.8443], [27.6176, 29.2145], [23.5417, 33.0491], [18.9816, 36.2816], [14.0288, 38.859], [8.7792, 40.7418], [3.3307, 41.9044], [-2.2179, 42.3347], [-7.7694, 42.0336], [-13.2293, 41.0145], [-18.5073, 39.3023], [-23.519, 36.9325], [-28.1862, 33.9503], [-32.4387, 30.4092], [-36.2144, 26.3702], [-39.4604, 21.9], [-42.1328, 17.0702], [-44.1976, 11.9559], [-45.6306, 6.6344], [-46.4169, 1.1839], [-46.5514, -4.3173], [-46.0381, -9.7921], [-44.8898, -15.1657], [-43.1276, -20.3663], [-40.7801, -25.3262], [-37.8833, -29.9823], [-34.479, -34.2768], [-30.6151, -38.1579], [-26.3437, -41.5801], [-21.7212, -44.5045], [-16.8071, -46.8992], [-11.663, -48.7393], [-6.352, -50.0072], [-0.9381, -50.6921], [4.5151, -50.7904], [9.9446, -50.3053], [15.2889, -49.2466], [20.4888, -47.6301], [25.4876, -45.4777], [30.2321, -42.8167], [34.6727, -39.6793], [35.6093, -34.1005], [30.0305, -33.1639], [30.0305, -33.1639], [26.2907, -35.855], [22.294, -38.1428], [18.0826, -40.0005], [13.7017, -41.4056], [9.1992, -42.3401], [4.6253, -42.7912], [0.0318, -42.7511], [-4.5284, -42.2178], [-9.0017, -41.195], [-13.3348, -39.6921], [-17.4748, -37.7246], [-21.3703, -35.3139], [-24.972, -32.4873], [-28.2333, -29.2777], [-31.1109, -25.7237], [-33.5658, -21.8689], [-35.5634, -17.7618], [-37.0749, -13.455], [-38.0769, -9.0052], [-38.5529, -4.4719], [-38.493, 0.0827], [-37.8948, 4.5951], [-36.7635, 9.0007], [-35.1119, 13.2352], [-32.9611, 17.2353], [-30.3397, 20.9399], [-27.2846, 24.2908], [-23.8397, 27.234], [-20.0566, 29.7206], [-15.9932, 31.7076], [-11.7134, 33.1594], [-7.2866, 34.0482], [-2.786, 34.3549], [1.7117, 34.0699], [6.1279, 33.1939], [10.3834, 31.7378], [14.3997, 29.7237], [18.1006, 27.1845], [21.4135, 24.1638], [24.2714, 20.7162], [26.6141, 16.9059], [28.3902, 12.8067], [29.5581, 8.5005], [30.0879, 4.0761], [29.9625, -0.3721], [29.1786, -4.7462], [27.7479, -8.9466], [25.6972, -12.8741], [23.0694, -16.4328], [19.9228, -19.532], [16.3312, -22.0893], [12.3824, -24.0332], [8.1775, -25.3054], [3.8285, -25.864], [-0.5437, -25.6851], [-4.8124, -24.7656], [-8.8484, -23.1242], [-12.5235, -20.8032], [-15.7156, -17.8685], [-18.3121, -14.4099], [-20.2157, -10.5398], [-21.3488, -6.3913], [-21.6583, -2.1154], [-21.1203, 2.1236], [-19.7441, 6.153], [-17.5751, 9.7984], [-14.6973, 12.8913], [-11.2338, 15.278], [-7.3453, 16.8285], [-3.2269, 17.4472], [0.898, 17.0828], [4.7872, 15.7378], [8.1917, 13.4772], [10.8722, 10.4342], [12.618, 6.8134], [13.2708, 2.8875], [12.749, -1.0117], [11.0749, -4.5129], [8.3989, -7.2362], [5.0179, -8.8399], [1.3786, -9.0853], [-1.9491, -7.9227]];
    
    actual = shape_path_extend(
        stroke2, 
        [for(pa = pts_angles) pa[0]]
    );
    
    assertEqualPoints(expected, actual);  
}


test_shape_path_extend_stroke1();
test_shape_path_extend_stroke2();
