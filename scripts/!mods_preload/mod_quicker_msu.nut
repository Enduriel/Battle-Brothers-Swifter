::QuickerMSU <- {
	ID = "mod_quicker_msu",
	Name = "Quicker",
	Version = "0.1.0",
	EnableSpeed = true
}
::mods_registerMod(::QuickerMSU.ID, ::QuickerMSU.Version, ::QuickerMSU.Name);
::mods_queue(::QuickerMSU.ID, "mod_msu(>=1.0.0-alpha.4), !mod_legends, !quicker", function()
{
	::QuickerMSU.Mod <- ::MSU.Class.Mod(::QuickerMSU.ID, ::QuickerMSU.Version, ::QuickerMSU.Name);

	::Const.World.SpeedSettings.VeryfastMult <- 4.0;
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	local setSpeedMult = ::World.setSpeedMult;
	::World.setSpeedMult = function( _mult )
	{
		if (::QuickerMSU.EnableSpeed)
		{
			setSpeedMult(_mult);
		}
		else
		{
			::QuickerMSU.EnableSpeed = true
		}
	}

	::include("quicker/world_screen_topbar_daytime_module");
	::include("quicker/world_state");
	::include("quicker/tooltip_events");
	::include("quicker/tactical_state");

	::mods_registerJS("quicker/quicker.js");
	::mods_registerJS("quicker/world_screen_topbar_daytime_module.js");
	::mods_registerCSS("quicker/css/world_screen_topbar_daytime_module.css");

	::QuickerMSU.Mod.Keybinds.addSQKeybind("veryfastTime", "3", ::MSU.Key.State.World, function ()
	{
		this.setVeryfastTime();
		return false;
	}, "4x World Speed");

	::QuickerMSU.Mod.Keybinds.addSQKeybind("superfastTime", "4", ::MSU.Key.State.World, function ()
	{
		this.setSuperfastTime();
		return false;
	}, "8x World Speed");

	local page = ::QuickerMSU.Mod.ModSettings.addPage("Tactical");

	local setting = page.addRangeSetting("CombatSpeed", 1, 1, 4, 0.5, "Combat Speed");
	setting.setDescription("Increases the animation speed of all engagements.");
	setting.addCallback(function(_value)
	{
		::Time.setVirtualSpeed(_value);
	});
});
