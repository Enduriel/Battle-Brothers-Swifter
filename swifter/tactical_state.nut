::mods_hookExactClass("states/tactical_state", function (o)
{
	local tactical_flee_screen_onFleePressed = o.tactical_flee_screen_onFleePressed;
	o.tactical_flee_screen_onFleePressed = function()
	{
		tactical_flee_screen_onFleePressed();
		::Time.setVirtualSpeed(::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue() * 1.5);
	}

	local setPause = o.setPause;
	o.setPause = function( _f )
	{
		setPause(_f);
		if (!_f)
		{
			::Time.setVirtualSpeed(::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue());
		}
	}
});
