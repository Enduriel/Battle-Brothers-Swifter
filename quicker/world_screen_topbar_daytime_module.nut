::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function( o )
{
	local create = o.create;
	o.create = function()
	{
		this.m.OnTimeVeryfastPressedListener <- null;
		this.m.OnTimeSuperfastPressedListener <- null;
	}

	o.setOnTimeVeryfastPressedListener <- function( _listener )
	{
		this.m.OnTimeVeryfastPressedListener = _listener;
	}

	o.setOnTimeSuperfastPressedListener <- function( _listener )
	{
		this.m.OnTimeSuperfastPressedListener = _listener;
	}

	o.onTimeVeryfastButtonPressed <- function()
	{
		if (this.m.OnTimeVeryfastPressedListener != null)
		{
			this.m.OnTimeVeryfastPressedListener();
		}
	}

	o.onTimeSuperfastButtonPressed <- function()
	{
		if (this.m.OnTimeSuperfastPressedListener != null)
		{
			this.m.OnTimeSuperfastPressedListener();
		}
	}
});
