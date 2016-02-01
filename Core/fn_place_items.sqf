
_positions    = _this select 0;
_itemsToPlace = _this select 1;

_items = [];
{
    _item = createVehicle[_itemsToPlace call BIS_fnc_selectRandom, [0,0,300], [], 0, "NONE"];
    _item allowDamage false;
    _item setPos _x;
    _item allowDamage true;
    _items pushback _item;
}forEach _positions;

MAM_ITEM_COUNT = MAM_ITEM_COUNT + (count _items);

_items