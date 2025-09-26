function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        START,
        A,
        B,
        X,
        Y,
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
    }

        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",		[vk_right, "D"],    [ gp_axislh, gp_padr]);
        InputDefineVerb(INPUT_VERB.START,	"start",		vk_space,            gp_start);
        InputDefineVerb(INPUT_VERB.A,		"a",			vk_space,        gp_face1);
        InputDefineVerb(INPUT_VERB.B,		"b",			"X",            gp_face2);
        InputDefineVerb(INPUT_VERB.X,		"x",			"Z",            gp_face3);
        InputDefineVerb(INPUT_VERB.Y,		"y",			"C",          gp_face4 );
}
