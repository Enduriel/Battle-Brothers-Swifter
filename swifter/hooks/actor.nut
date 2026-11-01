::Swifter.QueueBucket.Late.push(function() {
	::Swifter.HookMod.hook("scripts/entity/tactical/actor", function(q) {
		// Slow down based on VirtualSpeed so that render animations of ghost, spider etc. don't run at faster speeds.
		q.moveSpriteOffset = @(__native) { function moveSpriteOffset( _name, _from, _to, _duration, _startAtTime )
		{
			return __native(_name, _from, _to, _duration * ::Time.getVirtualSpeed(), _startAtTime);
		}}.moveSpriteOffset;
	});
});
