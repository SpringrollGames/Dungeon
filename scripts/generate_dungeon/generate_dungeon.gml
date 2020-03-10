///@func generate_dungeon(width,height,tiles)
///@args width,height,tiles
///@desc Generates a grid for dungeon layout and the layout of each room
var _w = argument[0];
var _h = argument[1];
var _t = argument[2];

var _a = array_create_2d(_w, _h, TILE.none);
var _i = array_create_2d(_w, _h, ITEM.none);
var _x = dx;
var _y = dy;
var _dir = irandom(4);

_a[_x, _y] = TILE.door_back;
_x += ceil(lengthdir_x(1, _dir * 90));
_y += ceil(lengthdir_y(1, _dir * 90));
_x = clamp(_x, 0, _w - 1);
_y = clamp(_y, 0, _h - 1);

repeat(_t) {
	if (_a[_x, _y] == TILE.none) {
		_a[_x, _y] = TILE.ground;
	}
	_x += ceil(lengthdir_x(1, _dir * 90));
	_y += ceil(lengthdir_y(1, _dir * 90));
	_dir += irandom_range(-1, 1);
	_x = clamp(_x, 0, _w - 1);
	_y = clamp(_y, 0, _h - 1);
	
	//Items
	if (irandom(100) < 10) {
		_i[_x, _y] = ITEM.coin;
	}	
}

_a[_x, _y] = TILE.door;

dx = _x;
dy = _y;

var _dungeon = [];
_dungeon[DUNGEON.floorplan] = _a;
_dungeon[DUNGEON.items] = _i;
ds_list_add(dungeons, _dungeon);