::Swifter.HookMod.hook("scripts/states/world_state", function (q)
{
	q.onInitUI = @(__original) function()
	{
		__original();
		this.m.WorldScreen.getTopbarDayTimeModule().setOnTimeSuperfastPressedListener(this.setSuperfastTime.bindenv(this));
	}

	q.updateTopBarButtonState = @(__original) function()
	{
		__original();
		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null && !this.isPaused() && this.World.getSpeedMult() == ::Const.World.SpeedSettings.SuperfastMult)
		{
			this.World.TopbarDayTimeModule.updateTimeButtons(4);
		}
	}

	// vanilla ignores 4x while camping or escorting, which would leave you stuck at 8x
	// forcing is safe because setPause still raises the speed to the camping or escort minimum
	q.setVeryFastTime = @(__original) function( _force = false )
	{
		return __original(true);
	}

	q.setSuperfastTime <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.SuperfastMult;
			this.setPause(false);
		}
	}
});
