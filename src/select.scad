module select(i) {
    if(is_undef(i)) {
        children();
    }
    else {
        children(i);
    }
}	