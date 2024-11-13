// Parameters
depth = orders.gui;
image_alpha = 1;
sprite_index = noone;

// Variables
font = Player.ast_hud.font;

timer = {
    display: false,
    icon: spr_hud_timer,
    pos_icon: [25, 20],
    pos_info: [55, 25],
};

rings = {
    display: false,
    icon: spr_hud_rings,
    pos_icon: [25, 45],
    pos_info: [55, 48],
};

stamina = {
    display: false,
    icon: spr_hud_stamina,
    colors: Player.ast_hud.colors_stamina,
    pos_icon: [25, 217.6],
    pos_info: [32, 225.1, 33, 226.1],
};

life = {
    display: false,
    icon: Player.ast_hud.spr_lives,
    pos_icon: [364.8, 20],
    pos_info: [394.8, 23],
};
