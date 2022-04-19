::mods_hookExactClass("states/world_state", function ( o )
{
	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		onInitUI();
		local dayTimeModule = this.m.WorldScreen.getTopbarDayTimeModule();
		dayTimeModule.setOnTimeVeryfastPressedListener(this.setVeryfastTime.bindenv(this));
		dayTimeModule.setOnTimeSuperfastPressedListener(this.setSuperfastTime.bindenv(this));
	}

	local setPause = o.setPause;
	o.setPause = function( _f )
	{
		setPause(_f);
		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null)
		{
			if (this.m.IsGamePaused) return;

			if (this.World.getSpeedMult() == 4.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(3);
			}
			else if (this.World.getSpeedMult() == 8.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(4);
			}
		}
	}

	o.setVeryfastTime <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Assets.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.VeryfastMult;
			}

			this.setPause(false);
		}
	}

	o.setSuperfastTime <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Assets.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.SuperfastMult;
			}

			this.setPause(false);
		}
	}
});
