/// @description


//Menu
if (state == GAMESTATE.menu || (state == GAMESTATE.normal && menu_time > 0)) {
	draw_set_alpha(0.5 * menu_time);
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	
	draw_set_alpha(menu_time);
	draw_set_font(fnt_big);
	draw_set_color($eeeeee);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(display_get_gui_width() div 2, 32, "MENU");
	
	draw_set_alpha(1);
}

//Top bar
draw_set_font(fnt_font);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_color(merge_color($eeeeee, $62cc3b, coin_fade));
draw_text(32, 32, "Money: " + string(coins));