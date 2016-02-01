
{
    _marker  = _x select 0;
    _nCaches = _x select 1;
    _spacing = _x select 2;
    _nDecoys = 0;
    _locs    = [];
    if(count _x > 3) then{ _nDecoys = _x select 3; };

    if(_nCaches > 0) then{ //actual caches
        _locs   = [_marker,_nCaches,_spacing] call MAM_fnc_get_locations;
        _caches = [_locs,MAM_CACHE_BOXES] call MAM_fnc_place_items;
        _marks  = [_locs] call MAM_fnc_place_markers;
        [_caches,_marks] call MAM_fnc_add_eventHandlers;
    };

    if(_nDecoys > 0) then{ //decoy markers
        _decoyLocs  = [_marker,_nDecoys,_spacing,_locs] call MAM_fnc_get_locations;
        _decoyMarks = [_decoyLocs,true] call MAM_fnc_place_markers;
    };

}forEach (_this select 0);