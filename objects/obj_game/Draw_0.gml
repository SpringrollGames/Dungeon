/// @description
for(var j = max(0, current_dungeon - 1); (j <= current_dungeon + 1 && j < ds_list_size(dungeons)); j++) {
	var _dungeon = dungeons[| j];
	var _a = _dungeon[@ DUNGEON.floorplan];
	var _i = _dungeon[@ DUNGEON.items];
	var _diff = transition_dungeon - j;
	var _alpha = 1 - abs(_diff);
	var _off_y = _diff * S;
	if (_diff == 0 || _alpha != 0) {
		for(var i = 0; i < array_height_2d(_a); i++) {
			for(var m = 0; m < array_length_2d(_a, i); m++) {
				var _tile = _a[i, m];
				var _item = _i[i, m];
				switch(_tile) {
					case TILE.ground:
						draw_sprite_ext(spr_dot, 0, x + (i * S), y + (m * S) + _off_y, 1, 1, 0, c_white, _alpha);
						draw_sprite_ext(spr_dot, 1, x + (i * S), y + (m * S) + _off_y, 1, 1, 0, c_white, _alpha * (0.25 + abs(dsin((current_time / 50) + (i + m) * 2)) * 0.75));
						break;
					case TILE.door:
						draw_sprite_ext(spr_door, 0, x + (i * S), y + (m * S) + _off_y, 1, 1, 0, c_white, _alpha);
						break;
					case TILE.door_back:
						draw_sprite_ext(spr_door, 1, x + (i * S), y + (m * S) + _off_y, 1, 1, 0, c_white, _alpha);
						break;
					default: break;
				}
				switch(_item) {
					case ITEM.coin:
						draw_sprite_ext(spr_coin, 0, x + (i * S), y + (m * S) + _off_y, 1, 1, 0, c_white, _alpha);
						break;
					default: break;
				}
			}
		}
	}
}

//Player
draw_sprite(spr_player, 0, draw_x, draw_y);