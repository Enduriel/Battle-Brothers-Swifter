::Swifter.HookMod.hook("scripts/events/event_manager", function(q) {
	q.selectEvent = @(__original) function() {
		local selectEventGenerator = __original();
		while (true)
		{
			for (local i = 0; i < ::World.getSpeedMult(); ++i)
			{
				if (resume selectEventGenerator == true)
					return true;
			}
			yield false;
		}
	}
})
