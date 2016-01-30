
//fnc_get_item_locations = compile preprocessFile "ArmaModules\get_item_locations.sqf";
//fnc_place_items = compile preprocessFile "ArmaModules\place_items.sqf";
//fnc_place_markers = compile preprocessFile "ArmaModules\place_markers.sqf";

if(!isServer) exitWith{};

_ITEMSTOPLACE = ["Box_FIA_Support_F"];

_locs  = ["PLACEMARK",3] call MAM_fnc_get_locations;
_items = [_locs,_ITEMSTOPLACE] call MAM_fnc_place_items;
_marks = [_locs] call MAM_fnc_place_markers;
_null = [_items,_marks] call MAM_fnc_add_eventHandlers;