
main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_convoy");

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.sunlight = 1.6;
}
