
_positions = _this select 0;
_decoys = false;
if(count _this > 1) then{ _decoys = _this select 1; };

_markers = [];
{
    _cnt = MAM_MARKER_COUNT;
    _markerName = format["item%1",_cnt];
    _markerRvar = floor(MAM_MARKER_R * 0.2);
    
    _rran = 1; _xran = 1; _yran = 1;
    if(random 1 > 0.5) then{_rran = -1;};
    if(random 1 > 0.5) then{_xran = -1;};
    if(random 1 > 0.5) then{_yran = -1;};

    _radius = MAM_MARKER_R + (_rran * (random _markerRvar));
    _r = _radius * 0.9;
    _xRanPos = random _r;
    _yRanPos = random (sqrt( (_r*_r) / (_xRanPos*_xRanPos)));
    _marker = createMarker [_markerName, [(_x select 0) + (_xran * _xRanPos), 
                                          (_x select 1) + (_yran * _yRanPos),0]];

    _marker setMarkerType "empty";
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerColor MAM_DEFAULT_MARKER_COLOR;
    _marker setMarkerBrush MAM_DEFAULT_MARKER_BRUSH;
    _marker setMarkerSize [_radius,_radius];
    _marker setMarkerAlpha 0.8;

    if(MAM_DEBUG && !_decoys) then{
        _dmarker = createMarker [format["pinpoint%1",_cnt],_x];
        _dmarker setMarkerType "empty";
        _dmarker setMarkerShape "ELLIPSE";
        _dmarker setMarkerColor "ColorRed";
        _dmarker setMarkerSize [5.0,5.0];
    };
    MAM_MARKER_COUNT = MAM_MARKER_COUNT + 1;
    _markers pushback _marker;
}forEach _positions;

_markers