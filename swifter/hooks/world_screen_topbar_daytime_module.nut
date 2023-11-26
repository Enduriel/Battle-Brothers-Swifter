::Swifter.HookMod.hook("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(q) {
	q.m.OnTimeVeryfastPressedListener <- null;
	q.m.OnTimeSuperfastPressedListener <- null;

	q.clearEventListener = @(__original) function()
	{
		__original();
		this.m.OnTimeVeryfastPressedListener = null;
		this.m.OnTimeSuperfastPressedListener = null;
	}

	q.setOnTimeVeryfastPressedListener <- function( _listener )
	{
		this.m.OnTimeVeryfastPressedListener = _listener;
	}

	q.setOnTimeSuperfastPressedListener <- function( _listener )
	{
		this.m.OnTimeSuperfastPressedListener = _listener;
	}

	q.onTimeVeryfastButtonPressed <- function()
	{
		if (this.m.OnTimeVeryfastPressedListener != null)
		{
			this.m.OnTimeVeryfastPressedListener();
		}
	}

	q.onTimeSuperfastButtonPressed <- function()
	{
		if (this.m.OnTimeSuperfastPressedListener != null)
		{
			this.m.OnTimeSuperfastPressedListener();
		}
	}
})

