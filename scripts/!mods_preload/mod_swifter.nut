::Swifter <- {
	ID = "mod_swifter",
	Name = "Swifter",
	Version = "1.2.0",
	EnableSpeed = true,
	Delays = {
		NewTurnDelayWithFasterMovement = ::Const.AI.Agent.NewTurnDelayWithFasterMovement,
		NewTurnDelay = ::Const.AI.Agent.NewTurnDelay,
		NewEvaluationDelay = ::Const.AI.Agent.NewEvaluationDelay,
		CameraAdditionalDelay = ::Const.AI.Agent.CameraAdditionalDelay
	}
}
::Swifter.HookMod <- ::Hooks.register(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
::Swifter.HookMod.require("mod_msu >= 1.2.0-rc.1");
::Swifter.HookMod.conflictWith("mod_legends < 16.0.0-alpha", "mod_autopilot [Use Hackflow's updated version instead]", "quicker", "mod_faster", "mod_fastest");

::Swifter.HookMod.queue(">mod_msu", "<mod_legends", function(){
	::Swifter.Mod <- ::MSU.Class.Mod(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
	::Swifter.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Enduriel/Battle-Brothers-Swifter");
	::Swifter.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::Const.World.SpeedSettings.VeryfastMult <- 4.0;
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	::Const.World.SpeedSettings.EscortMult = ::Const.World.SpeedSettings.VeryfastMult;
	::Const.World.SpeedSettings.CampMult = ::Const.World.SpeedSettings.FastMult;

	local setSpeedMult = ::World.setSpeedMult;
	::World.setSpeedMult = function( _mult )
	{
		if (::Swifter.EnableSpeed || _mult == 0.0)
		{
			setSpeedMult(_mult);
		}
		else
		{
			::Swifter.EnableSpeed = true
		}
	}

	local teleport = ::TacticalNavigator["__sqrat_ol_ teleport_6"];
	::TacticalNavigator["__sqrat_ol_ teleport_6"] <- function( _user, _targetTile, _callback, _tag, _unknownBool, _delay )
	{
		return teleport(_user, _targetTile, _callback, _tag, _unknownBool, _delay / ::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue().tofloat());
	}

	::include("swifter/world_screen_topbar_daytime_module");
	::include("swifter/world_state");
	::include("swifter/tooltip_events");
	::include("swifter/tactical_state");
	::include("swifter/event_manager");
	::include("swifter/agent");
	::include("swifter/turn_sequence_bar");

	::Hooks.registerJS("ui/mods/swifter/swifter.js");
	::Hooks.registerJS("ui/mods/swifter/turnsequencebar_module.js");
	::Hooks.registerJS("ui/mods/swifter/world_screen_topbar_daytime_module.js");
	::Hooks.registerLateJS("ui/mods/swifter/store_turnsequencebar_values.js");
	::Hooks.registerCSS("ui/mods/swifter/css/world_screen_topbar_daytime_module.css");

	::Swifter.Mod.Keybinds.addTitle("WorldKeybindsTitle", "World Keybinds");
	::Swifter.Mod.Keybinds.addSQKeybind("veryfastTime", "3", ::MSU.Key.State.World, function ()
	{
		this.setVeryfastTime();
		return true;
	}, "4x World Speed");

	::Swifter.Mod.Keybinds.addSQKeybind("superfastTime", "4", ::MSU.Key.State.World, function ()
	{
		this.setSuperfastTime();
		return true;
	}, "8x World Speed");

	::Swifter.Mod.Keybinds.addTitle("TacticalKeybindsTitle", "Combat Keybinds");

	::Swifter.Mod.Keybinds.addSQKeybind("NormalTimeTactical", "f1", ::MSU.Key.State.Tactical, function()
	{
		::Swifter.Mod.ModSettings.getSetting("CombatSpeed").set(1);
		return true;
	}, "1x Combat Speed");

	::Swifter.Mod.Keybinds.addSQKeybind("FastTimeTactical", "f2", ::MSU.Key.State.Tactical, function()
	{
		::Swifter.Mod.ModSettings.getSetting("CombatSpeed").set(2);
		return true;
	}, "2x Combat Speed");

	::Swifter.Mod.Keybinds.addSQKeybind("VeryFastTimeTactical", "f3", ::MSU.Key.State.Tactical, function()
	{
		::Swifter.Mod.ModSettings.getSetting("CombatSpeed").set(3);
		return true;
	}, "3x Combat Speed");

	::Swifter.Mod.Keybinds.addSQKeybind("SuperFastTimeTactical", "f4", ::MSU.Key.State.Tactical, function()
	{
		::Swifter.Mod.ModSettings.getSetting("CombatSpeed").set(4);
		return true;
	}, "4x Combat Speed");

	local page = ::Swifter.Mod.ModSettings.addPage("General");

	local setting = page.addRangeSetting("CombatSpeed", 1, 1, 4, 0.5, "Combat Speed", "Increases the animation speed of all engagements.");
	setting.addCallback(function(_value)
	{
		::Time.setVirtualSpeed(_value);
		foreach (key, value in ::Swifter.Delays)
		{
			::Const.AI.Agent[key] = ::Math.round(value / _value);
		}
		if ("State" in ::Tactical && ::Tactical.State != null) ::Tactical.State.m.TacticalScreen.getTurnSequenceBarModule().swifter_updateSpeeds(_value);
	});

	setting = page.addRangeSetting("EventFrequency", 1.0, 0.25, 5, 0.25, "Event Frequency", "Multiplies the frequency of Events by this value");
	setting.addCallback(function(_value)
	{
		::Const.Events.GlobalMinDelay = 240.0 / _value;
		::Const.Events.GlobalBaseChance = 1.0 * _value;
		::Const.Events.GlobalChancePerSecond = 0.21 * _value;
		::Const.Events.AllottedTimePerEvaluationRun = 0.001 * _value;
	});

	page.addBooleanSetting("Spin", false, "Magda Mode", "Don't throw up!");
});
