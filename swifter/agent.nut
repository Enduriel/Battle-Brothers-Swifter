::mods_hookBaseClass("ai/tactical/agent", function(o) {
	o = o[o.SuperName];

	local adjustCameraToTarget = o.adjustCameraToTarget;
	// _targetTile, _additionalDelay = 0
	o.adjustCameraToTarget = function( ... )
	{
		if (vargv.len() == 2) vargv[1] *= 1.0 / ::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue();
		vargv.insert(0, this);
		return adjustCameraToTarget.acall(vargv);
	}
});
