::Swifter.HookMod.hook("scripts/ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function(q) {
	q.swifter_updateSpeeds <- function( _mult )
	{
		this.m.JSHandle.asyncCall("swifter_updateSpeeds", _mult);
	}
})
