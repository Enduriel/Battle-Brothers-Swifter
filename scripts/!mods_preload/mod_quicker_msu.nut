::QuickerMSU <- {
	ID = "mod_quicker_msu",
	Name = "Quicker",
	Version = "0.1.0"
}
::mods_registerMod(::QuickerMSU.ID, 1.0, ::QuickerMSU.Name);
::mods_queue(::QuickerMSU.ID, "mod_msu, !mod_legends, !quicker", function()
{
	::QuickerMSU.Mod <- ::MSU.Class.Mod(::QuickerMSU.ID, ::QuickerMSU.Version, ::QuickerMSU.Name);

	::Const.World.SpeedSettings.VeryfastMult <- 4.0;
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	::include("quicker/world_screen_topbar_daytime_module");
	::include("quicker/world_state");
	::include("quicker/tooltip_events");

	::mods_registerJS("quicker/quicker.js");
	::mods_registerJS("quicker/world_screen_topbar_daytime_module.js");
	::mods_registerCSS("quicker/css/world_screen_topbar_daytime_module.css");

	::QuickerMSU.Mod.Keybinds.addSQKeybind("veryfastTime", "3", ::MSU.Key.State.World, function ()
	{
		this.setVeryfastTime();
	}, "4x World Speed");

	::QuickerMSU.Mod.Keybinds.addSQKeybind("superfastTime", "4", ::MSU.Key.State.World, function ()
	{
		this.setSuperfastTime();
	}, "8x World Speed");
});
