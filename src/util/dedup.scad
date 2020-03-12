use <util/_impl/_dedup_impl.scad>;

function dedup(lt) = _dedup(lt, [], len(lt));