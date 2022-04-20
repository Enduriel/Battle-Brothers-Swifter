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

	local function updateQuickerSpeeds()
	{
		if (this.World.getSpeedMult() == 4.0)
		{
			this.World.TopbarDayTimeModule.updateTimeButtons(3);
		}
		else if (this.World.getSpeedMult() == 8.0)
		{
			this.World.TopbarDayTimeModule.updateTimeButtons(4);
		}
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function()
	{
		::QuickerMSU.EnableSpeed = false;
		onUpdate();
		::QuickerMSU.EnableSpeed = true;
	}

	local setPause = o.setPause;
	o.setPause = function( _f )
	{
		setPause(_f);
		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null)
		{
			if (this.m.IsGamePaused) return;
			updateQuickerSpeeds();
		}
	}

	local setEscortedEntity = o.setEscortedEntity;
	o.setEscortedEntity = function( _e )
	{
		setEscortedEntity(_e);
		if (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull() && this.m.EscortedEntity.isAlive())
		{
			updateQuickerSpeeds();
		}
	}

	local onCamp = o.onCamp;
	o.onCamp = function()
	{
		onCamp();
		if (this.World.Assets.isCamping())
		{
			updateQuickerSpeeds();
		}
	}

	local function setSpeedMults()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (this.World.Assets.isCamping()) this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.CampMult;
			if (this.m.EscortedEntity != null) this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.EscortMult;
		}
	}

	local setNormalTime = o.setNormalTime;
	o.setNormalTime = function()
	{
		setSpeedMults();
		setNormalTime();
	}

	local setFastTime = o.setFastTime;
	o.setFastTime = function()
	{
		setSpeedMults();
		setFastTime();
	}

	o.setVeryfastTime <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.VeryfastMult;
			this.setPause(false);
		}
	}

	o.setSuperfastTime <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.SuperfastMult;
			this.setPause(false);
		}
	}
});
