
_items = _this select 0;
_marks = _this select 1;

for [{_i=0}, {_i<count _items}, {_i=_i+1}] do{
    (_items select _i) setVariable["MARKER",(_marks select _i)];
    (_items select _i) addEventHandler["Killed",{
        _mymark = (_this select 0) getVariable "MARKER";
        _killer =  _this select 1;
        _color  = "ColorBlack";
        if(isPlayer _killer) then{
            _color = format["Color%1",side _killer];
        };
        _mymark setMarkerColor _color;
        _mymark setMarkerAlpha 0.6;
        [MAM_ITEM_KILLED_MESSAGE] call MAM_fnc_broadcast;
    }];
};