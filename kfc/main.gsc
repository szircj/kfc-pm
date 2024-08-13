// Made by szir & yowisf for KFC Mod
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include kfc\_antiafk.gsc;
#include kfc\_record.gsc; 
#include kfc\_anti_cheat.gsc;
#include kfc\_spectator_list.gsc; 

init()
{
	level thread serverHandler();
	for (;;)
	{
		level waittill("connected", player);
		player thread playerHandler();
	}
}

serverHandler()
{
    thread kfc_flags::init();
    thread kfc_cmds::main(); 
    thread kfc_antiafk::init();
    thread setServerDvar();
    thread kfc_spectator_list::main();  
}

playerHandler()
{
    self thread setPlayerDvar();
}

setServerDvar()
{
    setDvar("jump_slowdownenable", 0);
}

setPlayerDvar()
{
    self setClientDvar("cl_maxpackets", 125);
}
