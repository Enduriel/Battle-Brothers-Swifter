::mods_hookNewObjectOnce("events/event_manager", function (o)
{
	local selectEvent = o.selectEvent;
	o.selectEvent = function()
	{
		local selectEventGenerator = selectEvent();
		while (true)
		{
			for (local i = 0; i < ::World.getSpeedMult(); ++i)
			{
				if (resume selectEventGenerator == true) return true;
			}
			yield false;
		}
	}
});
