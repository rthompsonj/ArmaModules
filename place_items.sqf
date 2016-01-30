
_positions    = _this select 0;
_itemsToPlace = _this select 1;

_items = [];
{
    _item = createVehicle[_itemsToPlace call BIS_fnc_selectRandom, _x, [], 0, "NONE"];
    _items pushback _item;
}forEach _positions;

_items