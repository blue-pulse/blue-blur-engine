// Parameters
depth = queue.gui;
sprite_index = noone;

// Variables
alpha = 1;
font = Player.ast_hud.font;

timer = {
    display: false,
    icon: spr_hud_timer,
    pos_icon: [15, 15],
    pos_info: [40, 20],
};

rings = {
    display: false,
    icon: spr_hud_rings,
    pos_icon: [15, 45],
    pos_info: [40, 48],
};

stamina = {
    display: false,
    icon: spr_hud_stamina,
    colors: Player.ast_hud.colors_stamina,
    pos_icon: [15, 210],
    pos_info: [22, 217.5, 23, 218.5],
};

life = {
    display: false,
    icon: Player.ast_hud.spr_lives,
    pos_icon: [356, 15],
    pos_info: [386, 20],
};
