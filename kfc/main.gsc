// Made by szir & yowisf for KFC Mod
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include kfc\_balance.gsc;
#include kfc\_antiafk.gsc;

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
        thread kfc\_flags::init();
	thread kfc\_cmds::main(); 
	thread kfc\_balance::init();
         thread kfc\_antiafk::init();
        thread setServerDvar();
       
        
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
