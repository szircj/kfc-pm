// Made by szir for KFC Mod

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
	thread setServerDvar();
        thread kfc\balance::_init();
        
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
