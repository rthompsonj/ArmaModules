
_positions = _this select 0;
_DEBUG = _this select 1;

_minMarkerR = 75;
_markers = [];
{
    _cnt = MAM_CNT;
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
    _marker = createMarker [_markerName, [(_x select 0) + (_xran * _xRanPos), 
                                          (_x select 1) + (_yran * _yRanPos),0]];

    _marker setMarkerType "empty";
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerColor "ColorBlue";
    _marker setMarkerSize [_radius,_radius];

    if(_DEBUG) then{
        _dmarker = createMarker [format["pinpoint%1",_cnt],_x];
        _dmarker setMarkerType "empty";
        _dmarker setMarkerShape "ELLIPSE";
        _dmarker setMarkerColor "ColorRed";
        _dmarker setMarkerSize [5.0,5.0];
    };
    //_cnt = _cnt + 1;
    MAM_CNT = MAM_CNT + 1;
    _markers pushback _marker;
}forEach _positions;

_markers