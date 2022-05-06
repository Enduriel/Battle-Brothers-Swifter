::Swifter <- {
	ID = "mod_swifter",
	Name = "Swifter",
	Version = "1.0.0-beta",
	EnableSpeed = true
}
::mods_registerMod(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
::mods_queue(::Swifter.ID, "mod_msu(>=1.0.0-beta), >mod_legends(>=16.0.0-alpha), !swifter", function()
{
	::Swifter.Mod <- ::MSU.Class.Mod(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);

	::Const.World.SpeedSettings.VeryfastMult <- 4.0;
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	local setSpeedMult = ::World.setSpeedMult;
	::World.setSpeedMult = function( _mult )
	{
		if (::Swifter.EnableSpeed)
		{
			setSpeedMult(_mult);
		}
		else
		{
			::Swifter.EnableSpeed = true
		}
	}

	::include("swifter/world_screen_topbar_daytime_module");
	::include("swifter/world_state");
	::include("swifter/tooltip_events");
	::include("swifter/tactical_state");

	::mods_registerJS("swifter/swifter.js");
	::mods_registerJS("swifter/world_screen_topbar_daytime_module.js");
	::mods_registerCSS("swifter/css/world_screen_topbar_daytime_module.css");

	::Swifter.Mod.Keybinds.addSQKeybind("veryfastTime", "3", ::MSU.Key.State.World, function ()
	{
		this.setVeryfastTime();
		return false;
	}, "4x World Speed");

	::Swifter.Mod.Keybinds.addSQKeybind("superfastTime", "4", ::MSU.Key.State.World, function ()
	{
		this.setSuperfastTime();
		return false;
	}, "8x World Speed");

	local page = ::Swifter.Mod.ModSettings.addPage("Tactical");

	local setting = page.addRangeSetting("CombatSpeed", 1, 1, 4, 0.5, "Combat Speed", "Increases the animation speed of all engagements.");
	setting.addCallback(function(_value)
	{
		::Time.setVirtualSpeed(_value);
	});

	local special = ::Swifter.Mod.ModSettings.addPage("Special");
	special.addBooleanSetting("Spin", false, "Magda Mode");
});
