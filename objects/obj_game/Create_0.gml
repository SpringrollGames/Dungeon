/// @description
#macro S 16
#macro cam view_camera[0]

enum GAMESTATE {
	normal,
	transition,
	menu,
	battle_menu,
	battling,
}

enum DUNGEON {
	floorplan,
	items,
	enemies,
}

enum TILE {
	none,
	wall,
	ground,
	door,
	door_back,
}

enum ITEM {
	none,
	coin,
}
	
enum ROOM {
	enemy,
	monster_house,
	bossfight,
	upgrade,
	item,
	key,
	final,
}
	
state = GAMESTATE.normal;	

dungeons = ds_list_create();
dx = 0;
dy = 0;
current_dungeon = 0;
transition_dungeon = 0;

generate_dungeon(10, 10, 30);
generate_dungeon(20, 20, 40);
generate_dungeon(20, 20, 50);
generate_dungeon(20, 20, 60);
generate_dungeon(20, 20, 70);
generate_dungeon(20, 20, 80);
generate_dungeon(20, 20, 90);
generate_dungeon(20, 20, 100);
generate_dungeon(20, 20, 120);
generate_dungeon(30, 30, 300);

cam_x = 0;
cam_y = 0;

draw_x = 0;
draw_y = 0;
player_x = 0;
player_y = 0;

//Collectibles
coins = 0;
coin_fade = 0;

//Menu
menu_time = 0;

//Camera
cam_x = draw_x - (camera_get_view_width(cam) / 2);
cam_y = draw_y - (camera_get_view_height(cam)/ 2);
camera_set_view_pos(cam, cam_x, cam_y);