
main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_citystreets");

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.sunlight = 0.78;

	maps\mp\_explosive_barrels::main();
}
