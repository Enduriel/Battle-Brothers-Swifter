Swifter.TurnSequenceBarModule = {};
Swifter.TurnSequenceBarModule.mFadeInDuration = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mFadeInDuration;
Swifter.TurnSequenceBarModule.mFadeOutDuration = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mFadeOutDuration;
Swifter.TurnSequenceBarModule.mFadeOutDurationIfHiddenToPlayer = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mFadeOutDurationIfHiddenToPlayer;
Swifter.TurnSequenceBarModule.mSlideInDuration = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mSlideInDuration;
Swifter.TurnSequenceBarModule.mSlideOutDuration = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mSlideOutDuration;
Swifter.TurnSequenceBarModule.mSlideOutDurationIfHiddenToPlayer = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mSlideOutDurationIfHiddenToPlayer;
Swifter.TurnSequenceBarModule.mResizeFirstSlotTime = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mResizeFirstSlotTime;
Swifter.TurnSequenceBarModule.mResizeFirstSlotTimeIfPreviousWasHiddenToPlayer = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mResizeFirstSlotTimeIfPreviousWasHiddenToPlayer;
Swifter.TurnSequenceBarModule.mStatsPanelFadeInTime = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mStatsPanelFadeInTime;
Swifter.TurnSequenceBarModule.mStatsPanelFadeOutTime = Screens.TacticalScreen.getModule("TurnSequenceBarModule").mStatsPanelFadeOutTime;

TacticalScreenTurnSequenceBarModule.prototype.swifter_updateSpeeds = function (_mult)
{
	var self = this;
	MSU.iterateObject(Swifter.TurnSequenceBarModule, function(_key, _value)
	{
		self[_key] = _value / _mult;
	});
}
