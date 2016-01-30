
//fnc_get_item_locations = compile preprocessFile "ArmaModules\get_item_locations.sqf";
//fnc_place_items = compile preprocessFile "ArmaModules\place_items.sqf";
//fnc_place_markers = compile preprocessFile "ArmaModules\place_markers.sqf";

if(!isServer) exitWith{};

MAM_CNT = 0;

_ITEMSTOPLACE = ["Box_FIA_Support_F"];

_locs  = ["PLACEMARK",3,50] call MAM_fnc_get_locations;
_items = [_locs,_ITEMSTOPLACE] call MAM_fnc_place_items;
_marks = [_locs,true] call MAM_fnc_place_markers;
_null  = [_items,_marks] call MAM_fnc_add_eventHandlers;

//decoy markers
_decoylocs  = ["PLACEMARK",2,50,_locs] call MAM_fnc_get_locations;
_decoyMarks = [_decoylocs,false] call MAM_fnc_place_markers;

_locs  = ["PLACEMORESHIT",2,50] call MAM_fnc_get_locations;
_items = [_locs,_ITEMSTOPLACE] call MAM_fnc_place_items;
_marks = [_locs,true] call MAM_fnc_place_markers;
_null  = [_items,_marks] call MAM_fnc_add_eventHandlers;

{
    deleteMarker _x;
}forEach ["PLACEMARK","PLACEMORESHIT"];