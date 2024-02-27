#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main() {
	makeDvarServerInfo( "cmd", "" );
	makeDvarServerInfo( "cmd1", "" );
	
	
	self endon("disconnect");
	while(1) {
		wait 0.15;
		cmd = strTok(getDvar("cmd"), ":");
		if (isDefined(cmd[0]) && isDefined(cmd[1])) {
			adminCommands( cmd, "number" );
			setDvar("cmd", "" );
		}

		cmd = strTok( getDvar("cmd1"), ":" );
		if (isDefined(cmd[0]) && isDefined(cmd[1])) {
			adminCommands( cmd, "nickname" );
			setDvar( "cmd1", "" );
		}
	}
}

adminCommands(cmd, pickingType) {

    if (!isDefined(cmd[1]))
        return;

    arg0 = cmd[0]; // command

    if (pickingType == "number")
        arg1 = int(cmd[1]); // player
    else
        arg1 = cmd[1];

    switch (arg0) {

    case "fps":
        player = getPlayer(arg1, pickingType);
        if (isDefined(player)) {
            if (!isDefined(player.pers["fb"])) {
                player.pers["fb"] = true;
                player setClientDvar("r_fullbright", 1);
                player iPrintLnBold("^5FullBright", "^3ON");
            } else {
                player.pers["fb"] = undefined;
                player setClientDvar("r_fullbright", 0);
                player iPrintLnBold("^5FullBright", "^2OFF");
            }
        }
        break;

    default:
        return;
    }
}

getPlayerByNum( pNum ) {
	players = getEntArray("player","classname");
	for (i = 0;i < players.size; i++) {
		if (players[i] getEntityNumber() == int(pNum)) 
			return players[i];
	}
}

getPlayer(arg1, pickingType) {
	if (pickingType == "number")
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
} 

getPlayerByName( nickname )  {
	players = getEntArray("player","classname");
	for (i = 0; i < players.size; i++) 
		if (isSubStr( toLower(players[i].name), toLower(nickname)))
			return players[i];
}