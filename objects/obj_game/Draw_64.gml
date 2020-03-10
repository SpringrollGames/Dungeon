/// @description
draw_set_font(fnt_font);
draw_set_color(merge_color($eeeeee, $62cc3b, coin_fade));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(32, 32, "Money: " + string(coins));