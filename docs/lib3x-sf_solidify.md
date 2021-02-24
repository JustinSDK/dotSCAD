# sf_solidify

It solidifies two square surfaces, described as a list of points `[x, y, z]`. 

**Since:** 2.3

## Parameters

- `surface1` : A list of points `[x, y, z]`.
- `surface2` : A list of points `[x, y, z]`.
- `slicing` : Given a rectangle, we have two ways to slice it into two triangles. Using this parameter to determine the way you want. It accepts `"SLASH"` (default) and `"BACK_SLASH"`.

## Examples

    use <surface/sf_solidify.scad>;

    function f(x, y) = 
    30 * (
        cos(sqrt(pow(x, 2) + pow(y, 2))) + 
        cos(3 * sqrt(pow(x, 2) + pow(y, 2)))
    );

    thickness = 2;
    min_value =  -200;
    max_value = 200;
    resolution = 10;

    surface1 = [
        for(y = [min_value:resolution:max_value])
            [
                for(x = [min_value:resolution:max_value]) 
                    [x, y, f(x, y) + 100]
            ]
    ];

    surface2 = [
        for(y = [min_value:resolution:max_value])
            [
                for(x = [min_value:resolution:max_value]) 
                    [x, y, -f(x, y) - 100]
            ]
    ];

    sf_solidify(surface1, surface2);

![sf_solidify](images/lib3x-sf_solidify-1.JPG)