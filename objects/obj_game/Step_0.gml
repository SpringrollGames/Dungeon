/// @description
switch(state) {
	case GAMESTATE.normal:
		//Player
		var _dungeon = dungeons[| current_dungeon];
		var _a = _dungeon[@ DUNGEON.floorplan];
		var _i = _dungeon[@ DUNGEON.items];
		var _dw = array_height_2d(_a);
		var _dh = array_length_2d(_a, 0);
		
		var _rl = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
		var _ud = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

		if (player_x + _rl >= 0 &&
			player_x + _rl <= _dw - 1 && 
			_a[player_x + _rl, player_y] != TILE.none) {
			player_x += _rl;
		}
		if (player_y + _ud >= 0 &&
			player_y + _ud <= _dh - 1 && 
			_a[player_x, player_y + _ud] != TILE.none) {
			player_y += _ud;
		}

		player_x = clamp(player_x, 0, _dw - 1);
		player_y = clamp(player_y, 0, _dh - 1);

		//Tiles
		if (_rl != 0 || _ud != 0) {
			var _tile = _a[player_x, player_y];
			var _item = _i[@ player_x, player_y];
			var _breakout = false;
			if not (_breakout) {
				switch(_tile) {
					case TILE.door:
						current_dungeon = min(ds_list_size(dungeons) - 1, current_dungeon + 1);
						state = GAMESTATE.transition;
						_breakout = true;
						break;
					case TILE.door_back:
						current_dungeon = max(0, current_dungeon - 1);
						state = GAMESTATE.transition;
						_breakout = true;
						break;
					default: break;
				}
			}
			if not (_breakout) {
				switch(_item) {
					case ITEM.coin:
						_i[@ player_x, player_y] = ITEM.none;
						coin_fade = 1;
						coins++;
						break;
					default: break;
				}
			}
		}
		break;
	case GAMESTATE.transition:
		//Transitions
		if (abs((draw_x / 16) - player_x) < 0.05 && abs((draw_y / 16) - player_y) < 0.05) {
			transition_dungeon = lerp(transition_dungeon, current_dungeon, 0.2);
			if (abs(transition_dungeon - current_dungeon) < 0.05) {
				transition_dungeon = current_dungeon;
				state = GAMESTATE.normal;
			}
		}
		break;
}

//Update animations
draw_x = lerp(draw_x, player_x * S, 0.3);
draw_y = lerp(draw_y, player_y * S, 0.3);
coin_fade = lerp(coin_fade, 0, 0.05);

//Camera
cam_x = lerp(cam_x, draw_x - (camera_get_view_width(cam) / 2), 0.1);
cam_y = lerp(cam_y, draw_y - (camera_get_view_height(cam)/ 2), 0.1);
camera_set_view_pos(cam, cam_x, cam_y);