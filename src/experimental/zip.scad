use <experimental/_impl/_zip_impl.scad>;

function zip(lt, lt2, lt3) = 
    is_undef(lt2) ? _zipAll(lt) :
    is_undef(lt3) ? _zip2(lt, lt2) : _zip3(lt, lt2, lt3);