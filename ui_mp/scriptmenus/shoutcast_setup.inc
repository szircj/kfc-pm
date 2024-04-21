#define BACK_OPEN;
#include "ui_mp/navcontrols.inc"

CHOICE_MENU_TITLE( "Shoutcast Setup" )

#undef CHOICE_X_START
#define CHOICE_X_START		-247

#undef CHOICE_HORIZONTAL_ALIGN
#define CHOICE_HORIZONTAL_ALIGN HORIZONTAL_ALIGN_CENTER

CHOICE_BUTTON( 14, "Players...", close self; open shoutcast_setup )
CHOICE_BUTTON( 15, "Binds...", close self; open shoutcast_setup_binds )
