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
::Swifter.Mod.Tooltips.setTooltips({
	TimeVeryfastButton = ::MSU.Class.CustomTooltip(function( _data ) {
		return [
			{
				id = 1,
				type = "title",
				text = "Very Fast Speed (" + ::getModSetting(::Swifter.ID, "veryfastTime").getValue() + ")"
			},
			{
				id = 2,
				type = "description",
				text = "Set time to pass much faster than normal. (4x Speed)"
			}
		];
	})
	TimeSuperfastButton = ::MSU.Class.CustomTooltip(function( _data ) {
		return [
			{
				id = 1,
				type = "title",
				text = "Super Fast Speed (" + ::getModSetting(::Swifter.ID, "superfastTime").getValue() + ")"
			},
			{
				id = 2,
				type = "description",
				text = "Set time to pass super quickly. (8x Speed)"
			}
		];
	})
})
