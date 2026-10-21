::Swifter <- {
	ID = "mod_swifter",
	Name = "Swifter",
	Version = "1.3.0",
	Delays = {
		NewTurnDelayWithFasterMovement = ::Const.AI.Agent.NewTurnDelayWithFasterMovement,
		NewTurnDelay = ::Const.AI.Agent.NewTurnDelay,
		NewEvaluationDelay = ::Const.AI.Agent.NewEvaluationDelay,
		CameraAdditionalDelay = ::Const.AI.Agent.CameraAdditionalDelay
	}
}
::Swifter.HookMod <- ::Hooks.register(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
::Swifter.HookMod.require("mod_msu >= 1.2.0-rc.1");
::Swifter.HookMod.conflictWith("mod_legends < 16.0.0-alpha", "mod_autopilot [Use Hackflow's 'Autopilot New' instead]", "quicker", "mod_faster", "mod_fastest");

::Swifter.HookMod.queue(">mod_msu", "<mod_legends", function(){
	::Swifter.Mod <- ::MSU.Class.Mod(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
	::Swifter.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Enduriel/Battle-Brothers-Swifter");
	::Swifter.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::Swifter.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/542");

	// vanilla has pause, 1x, 2x and 4x (VeryFastMult) and sets its own minimum speed while camping or escorting
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	local teleport = ::TacticalNavigator["__sqrat_ol_ teleport_6"];
	::TacticalNavigator["__sqrat_ol_ teleport_6"] <- function( _user, _targetTile, _callback, _tag, _unknownBool, _delay )
	{
		return teleport(_user, _targetTile, _callback, _tag, _unknownBool, _delay / ::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue().tofloat());
	}

	::include("swifter/msu");
	foreach (file in ::IO.enumerateFiles("swifter/hooks"))
	{
		::include(file);
	}
	::Hooks.registerJS("ui/mods/swifter/swifter.js");
	::Hooks.registerJS("ui/mods/swifter/turnsequencebar_module.js");
	::Hooks.registerJS("ui/mods/swifter/world_screen_topbar_daytime_module.js");
	::Hooks.registerLateJS("ui/mods/swifter/store_turnsequencebar_values.js");
	::Hooks.registerCSS("ui/mods/swifter/css/world_screen_topbar_daytime_module.css");
});
