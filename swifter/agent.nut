::Swifter.HookMod.hook("scripts/ai/tactical/agent", function(q) {
	q.adjustCameraToTarget = @(__original) function(_targetTile, _additionalDelay = 0) {
		return __original(_targetTile, _additionalDelay.tofloat() / ::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue())
	}
})
