::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function (o)
{
	o.swifter_updateSpeeds <- function( _mult )
	{
		this.m.JSHandle.asyncCall("swifter_updateSpeeds", _mult);
	}
});
