//------------------------------------------------------------------------------------
//    Date: January 29, 2016
// Purpose: Initialize R(andom)I(tem)P(lacement) module
//  Author: Monsoon
//   Email: rweezera@hotmail.com
//
// USAGE:
//   Place a marker over the area you would like to place items.
//   Then add the following line to your mission's init.sqf (or elsewhere):
//   _null = [["MARKERNAME",[ITEMS],nItems,nDecoys]] execVM "RCP\RCPinit.sqf";
//
// PARAMETERS:
//      This function accepts multiple arrays.  Each array is composed
//      of the following components:
//          MARKERNAME - name of the marker to place items under.
//             [ITEMS] - array of items to place.
//              nItems - how many items total to place?
//             nDecoys - how many decoy markers to place?
//
// EXAMPLE call with parameters:
//   _null = [["MYMARKER",["Box_FIA_Support_F"],10,2]] execVM "ArmaModules\RIP.sqf";
// This will place 10 Box_FIA_Support_F items within MYMARKER along with 2 decoy markers.
//
// EXAMPLE call with more than one marker:
//  _null = [["MYMARKER",["Box_FIA_Support_F"],10,2],["SECONDMARKER",["Box_FIA_Support_F"],2,0]] execVM "ArmaModules\RIP.sqf";
//------------------------------------------------------------------------------------

if(1==1) exitWith{};

_DEBUG             = true;
_placeMarkers      = true;
_placeDecoyMarkers = true;
_placeItems        = true;
_minMarkerR        = 75;

_placedItems = [];
_placedMarkers = [];
_cnt = 0;

//function to place marker in the vacinity of the "item"
_placeMarker = {
    private ["_itemPos","_markerName","_markerRvar","_rran","_xran","_yran","_r","_marker","_decoyMark","_dmarker"];
    _itemPos   = _this select 0;
    _decoyMark = _this select 1;
    _markerName = format["item%1",_cnt];
    _markerRvar = floor(_minMarkerR * 0.2);

    _rran = 1; _xran = 1; _yran = 1;
    if(random 1 > 0.5) then{_rran = -1;};
    if(random 1 > 0.5) then{_xran = -1;};
    if(random 1 > 0.5) then{_yran = -1;};

    _radius = _minMarkerR + (_rran * (random _markerRvar));
    _r = _radius * 0.9;
    _xRanPos = random _r;
    _yRanPos = random (sqrt( (_r*_r) / (_xRanPos*_xRanPos)));
    _marker = createMarker [_markerName, [(_itemPos select 0) + (_xran * _xRanPos), 
                                          (_itemPos select 1) + (_yran * _yRanPos),0]];

    _marker setMarkerType "empty";
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerColor "ColorBlue";
    _marker setMarkerSize [_radius,_radius];
    player sidechat format["%1",_radius];

    if(_DEBUG && !_decoyMark) then{
        _dmarker = createMarker [format["pinpoint%1",_cnt],_itemPos];
        _dmarker setMarkerType "empty";
        _dmarker setMarkerShape "ELLIPSE";
        _dmarker setMarkerColor "ColorRed";
        _dmarker setMarkerSize [5.0,5.0];
    };
    _cnt = _cnt + 1;
    _marker
};

//place item at specified location
_placeItem = {
    private ["_itemToPlace","_posToPlace","_item"];
    _itemToPlace = _this select 0;
    _posToPlace  = _this select 1;  

    _item = createVehicle[_itemToPlace, _posToPlace, [], 0, "NONE"];
    _item
};

//select a location to place an item or decoy marker
_selectLocation = {
    private ["_marker","_items","_nItems","_isDecoy"];
    _marker  = _this select 0;
    _items   = _this select 1;
    _nItems  = _this select 2;
    _isDecoy = _this select 3;

    _markerShape = markerShape _marker;
    _markerDir   = markerDir _marker;
    _markerPos   = getMarkerPos _marker;
    _markerSize  = getMarkerSize _marker;
 
    if (_markerShape == "ICON") exitWith{};

    _loc = createLocation(["Name", _markerPos] + _markerSize);
    _loc setDirection (markerDir _marker);
    if(_markerShape == "RECTANGLE") then{ _loc setRectangular true; };

    _range = (_markerSize select 0) max (_markerSize select 1);
    _houseList = nearestObjects [_markerPos,["house"],_range];

    for [{_i=0}, {_i<_nItems}, {_i=_i+1}] do{

        _placed = false;
        _iterations = 0;
        while{!_placed} do{
            _houseIndex = floor random (count _houseList);
            _house = _houseList select _houseIndex;
            _housePos = [_house] call BIS_fnc_buildingPositions;

            if(count _housePos > 0) then{
                _ranHousePos = _housePos call BIS_fnc_selectRandom;

                _minDistance = 10000;
                {
                    _dist = _x distance _ranHousePos;
                    if(_dist < _minDistance) then{_minDistance = _dist;};
                }forEach _placedItems;

                if(_ranHousePos in _loc && _minDistance > _minMarkerR) then{
                    _mark = [_ranHousePos,_isDecoy] call _placeMarker;
                    if(!_isDecoy) then{
                        _item = [_items call BIS_fnc_selectRandom, _ranHousePos] call _placeItem;
                        _placedItems pushback _item;
                        _placedMarkers pushBack _mark;

                        _item setVariable["MARK",_mark];
                    };
                    _placed = true;
                };
            };

            _houseList set [_houseIndex,-1];
            _houseList = _houseList - [-1];
            _iterations = _iterations + 1;
            if(_iterations > 1000) exitWith{};
        };
    };
    deleteLocation _loc;
};


{
    //DEFAULTS
    _items   = ["Box_FIA_Support_F"];
    _nItems  = 1;
    _nDecoys = 0;
    
    _marker  = _x select 0;
    _nPassed = count _x;
    if(_nPassed > 1) then{ _items   = _x select 1; };
    if(_nPassed > 2) then{ _nItems  = _x select 2; };
    if(_nPassed > 3) then{ _nDecoys = _x select 3; };

    [_marker, _items, _nItems, false] call _selectLocation;
    [_marker, _items, _nDecoys, true] call _selectLocation;
    deleteMarker _marker;
}forEach _this;

for [{_i=0}, {_i<count _placedItems}, {_i=_i+1}] do{
    _cache = _placedItems select _i;
    _mark  = _placedMarkers select _i;
    _cache addEventHandler["Killed", {
            diag_log "doing some stuff";
            ((_this select 0) getVariable "MARK") setMarkerColor "ColorRed";
    }];
};

[_placedItems,_placedMarkers]