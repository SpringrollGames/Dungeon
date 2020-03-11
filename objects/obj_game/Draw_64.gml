/// @description
var _w = display_get_gui_width();
var _h = display_get_gui_height();

//Menu
if (state == GAMESTATE.menu || (state == GAMESTATE.normal && menu_time > 0)) {
	draw_set_alpha(0.5 * menu_time);
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, _w, _h, false);
	
	draw_set_alpha(menu_time);
	draw_set_font(fnt_big);
	draw_set_color($eeeeee);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(_w div 2, -32 + (64 * menu_time), "MENU");	
}

//Battle Menu
if (state == GAMESTATE.battle_menu || (state == GAMESTATE.normal && battle_menu_time > 0)) {	
	//Options
	draw_set_alpha(battle_menu_time);
	draw_set_font(fnt_big);
	draw_set_color($eeeeee);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	var _dist = battle_menu_time * 200;
	for(var i = 0; i < array_length_1d(battle_menu_options); i++) {
		var _x = (_w div 2) + lengthdir_x(_dist, i * 90);
		var _y = (_h div 2) + lengthdir_y(_dist, i * 90);
		draw_text(_x, _y, battle_menu_options[i]);
	}
}

//Top bar
draw_set_alpha(1);
draw_set_font(fnt_font);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_color(merge_color($eeeeee, $62cc3b, coin_fade));
draw_text(32, 32, "Money: " + string(coins));