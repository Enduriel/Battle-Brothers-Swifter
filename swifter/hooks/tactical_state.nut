::Swifter.HookMod.hook("scripts/states/tactical_state", function(q) {
	q.tactical_flee_screen_onFleePressed = @(__original) function() {
		__original();
		::Time.setVirtualSpeed(::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue() * 1.5);
	}
	q.setPause = @(__original) function( _f ) {
		__original(_f);
		if (!_f)
			::Time.setVirtualSpeed(::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue());
	}
	q.onInitUI = @(__original) function() {
		__original();
		this.m.TacticalScreen.getTurnSequenceBarModule().swifter_updateSpeeds(::Swifter.Mod.ModSettings.getSetting("CombatSpeed").getValue());
	}
});
