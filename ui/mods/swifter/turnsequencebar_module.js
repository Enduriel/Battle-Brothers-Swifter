TacticalScreenTurnSequenceBarModule.prototype.swifter_updateSpeeds = function (_mult)
{
	var self = this;
	$.each(Swifter.TurnSequenceBarValues, function(_key, _value) {
		self[_key] = _value / _mult;
	});
}
