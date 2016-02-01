
_marker = _this select 0;
_nlocs  = _this select 1;
_itemSpacing = _this select 2;

_otherLocs = [];
if(count _this > 3) then{ _otherLocs = _this select 3;};

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

_locations = [];

for [{_i=0}, {_i<_nlocs}, {_i=_i+1}] do{

    _found = false;
    _iterations = 0;
    while{!_found} do{
        if(count _houseList <= 0) exitWith{diag_log "House List empty! Aborting";};
        _houseIndex = floor random (count _houseList);
        _house = _houseList select _houseIndex;
        _housePos = [_house] call BIS_fnc_buildingPositions;

        if(count _housePos > 0) then{
            _ranHousePos = _housePos call BIS_fnc_selectRandom;

            _minDistance = 10000;
            {
                _dist = _x distance _ranHousePos;
                if(_dist < _minDistance) then{_minDistance = _dist;};
            }forEach _locations;
            {
                _dist = _x distance _ranHousePos;
                if(_dist < _minDistance) then{_minDistance = _dist;};
            }forEach _otherLocs;

            if(_ranHousePos in _loc && _minDistance > _itemSpacing) then{
                _locations pushback _ranHousePos;
                _found = true;
            };
        };

        _houseList set [_houseIndex,-1];
        _houseList = _houseList - [-1];
        _iterations = _iterations + 1;
        if(_iterations > 1000) exitWith{diag_log "Exceeded 1000 iterations in house search, aborting";};
    };
};
deleteLocation _loc;

_locations