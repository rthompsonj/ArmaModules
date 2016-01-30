
fnc_get_item_locations = compile preprocessFile "ArmaModules\get_item_locations.sqf";
fnc_place_items = compile preprocessFile "ArmaModules\place_items.sqf";
fnc_place_markers = compile preprocessFile "ArmaModules\place_markers.sqf";

_ITEMSTOPLACE = ["Box_FIA_Support_F"];

_locs  = ["PLACEMARK",3] call fnc_get_item_locations;
_items = [_locs,_ITEMSTOPLACE] call fnc_place_items;
_marks = [_locs] call fnc_place_markers;