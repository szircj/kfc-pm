// Made by szir for KFC Promod

initSpectatorList()
{
    level.onPlayerSpectateChanged = ::onPlayerSpectateChanged;
    level thread monitorSpectators();
}

onPlayerSpectateChanged(player)
{
    player thread updateSpectatorHUD();
}

updateSpectatorHUD()
{
    self endon("disconnect");

    while (self.sessionstate == "spectator")
    {
        if (isDefined(self.spectatingHUD))
        {
            self.spectatingHUD destroy();
        }

        if (isDefined(self.spectatingList))
        {
            self.spectatingList destroy();
        }

        // Get the list of players who are spectating the current player
        spectators = [];
        foreach (player in level.players)
        {
            if (player getSpectatingPlayer() == self)
            {
                spectators[spectators.size] = player;
            }
        }

        // Display the number of spectators
        self.spectatingHUD = self createFontString("objective", 1.3);
        self.spectatingHUD setPoint("LEFT", "LEFT", 5, -100); // Adjust position as needed
        self.spectatingHUD setText(spectators.size + " spectators");
        self.spectatingHUD setColor((1, 1, 1)); // White color
        self.spectatingHUD setAlpha(0.8); // Transparency to avoid obstructing the view

     
        yOffset = -120; // Initial position for spectator names
        self.spectatingList = [];
        foreach (spectator in spectators)
        {
            hudElem = self createFontString("objective", 1);
            hudElem setPoint("LEFT", "LEFT", 5, yOffset); // Adjust position as needed
            hudElem setText(spectator.name);
            hudElem setColor((1, 1, 1)); // White color
            hudElem setAlpha(0.8); // Transparency
            self.spectatingList[self.spectatingList.size] = hudElem;
            yOffset -= 15; // Adjust space between names
        }

        wait 1; // Refresh every second
    }

    // Destroy the HUD if the player is no longer being spectated
    if (isDefined(self.spectatingHUD))
    {
        self.spectatingHUD destroy();
    }

    if (isDefined(self.spectatingList))
    {
        foreach (hudElem in self.spectatingList)
        {
            hudElem destroy();
        }
    }
}

monitorSpectators()
{
    while (true)
    {
        foreach (player in level.players)
        {
            player notify("spectate_changed");
        }
        wait 1;
    }
}

main()
{
    initSpectatorList();
}
