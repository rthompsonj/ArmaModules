
_items = _this select 0;
_marks = _this select 1;

for [{_i=0}, {_i<count _items}, {_i=_i+1}] do{
    (_items select _i) setVariable["MARKER",(_marks select _i)];
    (_items select _i) addEventHandler["Killed",{
        _mymark = (_this select 0) getVariable "MARKER";
        _mymark setMarkerColor "ColorBlack";
        _mymark setMarkerAlpha 0.5;
    }];
};