use <util/_impl/_dedup_impl.scad>;

function dedup(lt, sorted = false) = 
    sorted ?  _dedup_sorted(lt, len(lt)) :
              _dedup(lt, [], len(lt));