/// @description
var _rl = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
var _ud = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
var _m = keyboard_check_pressed(ord("C"));
var _b = keyboard_check(ord("X"));

switch(state) {
	#region NORMAL
	case GAMESTATE.normal:
		//Player
		var _dungeon = dungeons[| current_dungeon];
		var _a = _dungeon[@ DUNGEON.floorplan];
		var _i = _dungeon[@ DUNGEON.items];
		var _dw = array_height_2d(_a);
		var _dh = array_length_2d(_a, 0);
		
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

		var _breakout = false;

		//Tiles
		if (_rl != 0 || _ud != 0) {
			var _tile = _a[player_x, player_y];
			var _item = _i[@ player_x, player_y];
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
			
			//Items
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
		
		//Menu opening
		if not (_breakout) {
			menu_time = lerp(menu_time, 0, 0.2);
			if (_m) {
				state = GAMESTATE.menu;
				menu_time = 0;
				_breakout = true;
			}
		}
		
		//Battle Menu opening
		if not (_breakout) {
			battle_menu_time = lerp(battle_menu_time, 0, 0.2);
			if (_b) {
				state = GAMESTATE.battle_menu;
				battle_menu_time = 0;
				cam_w = width * 0.8;
				cam_h = height * 0.8;
				_breakout = true;
			}
		}
		break;
	#endregion
	#region TRANSITION
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
	#endregion
	#region MENU
	case GAMESTATE.menu:
		menu_time = lerp(menu_time, 1, 0.2);
		if (_m) {
			state = GAMESTATE.normal;
		}
		break;
	#endregion
	#region BATTLE MENU
	case GAMESTATE.battle_menu:
		battle_menu_time = lerp(battle_menu_time, 1, 0.2);
		if (!_b) {
			state = GAMESTATE.normal;
			cam_w = width;
			cam_h = height;
		}
		break;
	#endregion
}

//Update animations
draw_x = lerp(draw_x, player_x * S, 0.3);
draw_y = lerp(draw_y, player_y * S, 0.3);
coin_fade = lerp(coin_fade, 0, 0.05);

//Camera
cam_draw_w = lerp(cam_draw_w, cam_w, 0.2);
cam_draw_h = lerp(cam_draw_h, cam_h, 0.2);
if (abs(cam_draw_w - cam_w) < 3) {
	cam_draw_w = cam_w;
}
if (abs(cam_draw_h - cam_h) < 3) {
	cam_draw_h = cam_h;
}
cam_x = lerp(cam_x, draw_x, 0.1);
cam_y = lerp(cam_y, draw_y, 0.1);
camera_set_view_pos(cam, cam_x - (cam_draw_w / 2) + (S / 2), cam_y - (cam_draw_h / 2) + (S / 2));
camera_set_view_size(cam, cam_draw_w, cam_draw_h);