::Swifter.HookMod.hook("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(q) {
	q.m.OnTimeSuperfastPressedListener <- null;

	q.clearEventListener = @(__original) function()
	{
		__original();
		this.m.OnTimeSuperfastPressedListener = null;
	}

	q.setOnTimeSuperfastPressedListener <- function( _listener )
	{
		this.m.OnTimeSuperfastPressedListener = _listener;
	}

	q.onTimeSuperfastButtonPressed <- function()
	{
		if (this.m.OnTimeSuperfastPressedListener != null)
		{
			this.m.OnTimeSuperfastPressedListener();
		}
	}
})
