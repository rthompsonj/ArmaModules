
//fnc_get_item_locations = compile preprocessFile "ArmaModules\get_item_locations.sqf";
//fnc_place_items = compile preprocessFile "ArmaModules\place_items.sqf";
//fnc_place_markers = compile preprocessFile "ArmaModules\place_markers.sqf";

if(!isServer) exitWith{};
#include "MAM_Config.sqf"

_MAM_MARKERS = [
    ["PLACEMARK",2,100,1],
    ["PLACEMORESHIT",1,100,2]
];

[_MAM_MARKERS] call MAM_fnc_place_caches;

diag_log format["Placed %1 items",MAM_ITEM_COUNT];
diag_log format["Placed %1 markers",MAM_MARKER_COUNT];

[_MAM_MARKERS] call MAM_fnc_delete_markers;
