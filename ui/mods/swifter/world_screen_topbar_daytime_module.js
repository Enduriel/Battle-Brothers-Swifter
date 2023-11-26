Swifter.Hooks.WorldScreenTopbarDayTimeModule_updateButtons = WorldScreenTopbarDayTimeModule.prototype.updateButtons;
WorldScreenTopbarDayTimeModule.prototype.updateButtons = function (_state)
{
	Swifter.Hooks.WorldScreenTopbarDayTimeModule_updateButtons.call(this, _state);
	this.updateButtonIcons(_state)
}

WorldScreenTopbarDayTimeModule.prototype.updateButtonIcons = function (_state)
{
	if (_state !== this.mCurrentState)
	{
		this.mTimeButtons[this.mCurrentState].css('transform', 'rotate(0deg)');
		this.mCurrentRotation = 0;
		this.mCurrentState = _state;
	}
	this.mTimePauseButton.changeButtonImage(Path.GFX + (_state == 0 ? Swifter.Asset.BUTTON_PAUSE : Swifter.Asset.BUTTON_PAUSE_DISABLED));
	this.mTimeNormalButton.changeButtonImage(Path.GFX + (_state == 1 ? Swifter.Asset.BUTTON_PLAY : Swifter.Asset.BUTTON_PLAY_DISABLED));
	this.mTimeFastButton.changeButtonImage(Path.GFX + (_state == 2 ? Swifter.Asset.BUTTON_FAST_FORWARD : Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED));
	this.mTimeVeryfastButton.changeButtonImage(Path.GFX + (_state == 3 ? Swifter.Asset.BUTTON_VERYFAST : Swifter.Asset.BUTTON_VERYFAST_DISABLED));
	this.mTimeSuperfastButton.changeButtonImage(Path.GFX + (_state == 4 ? Swifter.Asset.BUTTON_SUPERFAST : Swifter.Asset.BUTTON_SUPERFAST_DISABLED));
}

Swifter.Hooks.WorldScreenTopbarDayTimeModule_createDIV = WorldScreenTopbarDayTimeModule.prototype.createDIV;
WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
{
	this.mTimeVeryfastButton = null;
	this.mTimeSuperfastButton = null;
	this.mTimeButtons = null;
	this.mCurrentState = null;
	this.mCurrentRotation = 0;
	Swifter.Hooks.WorldScreenTopbarDayTimeModule_createDIV.call(this, _parentDiv);
	var self = this;

	var layout = $('<div class="l-veryfast-time-button"/>');
	this.mContainer.append(layout);
	this.mTimeVeryfastButton = layout.createImageButton(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED, function ()
	{
		self.notifyBackendTimeVeryfastButtonPressed();

		self.updateButtonIcons(3)
	}, '', 10);

	layout = $('<div class="l-superfast-time-button"/>');
	this.mContainer.append(layout);
	this.mTimeSuperfastButton = layout.createImageButton(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED, function ()
	{
		self.notifyBackendTimeSuperfastButtonPressed();

		self.updateButtonIcons(4)
	}, '', 10);

	this.mTimePauseButton.on("click", function()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			self.updateButtonIcons(0);
		}
	});
	this.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE);

	this.mTimeNormalButton.on("click", function()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			self.updateButtonIcons(1)
		}
	});
	this.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);

	this.mTimeFastButton.on("click", function()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			self.updateButtonIcons(2)
		}
	});
	this.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
	this.mTimeButtons = [
		this.mTimePauseButton,
		this.mTimeNormalButton,
		this.mTimeFastButton,
		this.mTimeVeryfastButton,
		this.mTimeSuperfastButton
	]
	this.mCurrentState = 0;
}

Swifter.Hooks.WorldScreenTopbarDayTimeModule_bindTooltips = WorldScreenTopbarDayTimeModule.prototype.bindTooltips;
WorldScreenTopbarDayTimeModule.prototype.bindTooltips = function ()
{
	Swifter.Hooks.WorldScreenTopbarDayTimeModule_bindTooltips.call(this);

	this.mTimeVeryfastButton.bindTooltip({ contentType: 'ui-element', elementId: Swifter.TooltipIdentifier.TimeVeryfastButton });
	this.mTimeSuperfastButton.bindTooltip({ contentType: 'ui-element', elementId: Swifter.TooltipIdentifier.TimeSuperfastButton });
};

Swifter.Hooks.WorldScreenTopbarDayTimeModule_unbindTooltips = WorldScreenTopbarDayTimeModule.prototype.unbindTooltips;
WorldScreenTopbarDayTimeModule.prototype.unbindTooltips = function ()
{
	Swifter.Hooks.WorldScreenTopbarDayTimeModule_unbindTooltips.call(this);

	this.mTimeVeryfastButton.unbindTooltip();
	this.mTimeSuperfastButton.unbindTooltip();
}

WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeVeryfastButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeVeryfastButtonPressed');
}

WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeSuperfastButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeSuperfastButtonPressed');
}

WorldScreenTopbarDayTimeModule.prototype.rotateButtons = function ()
{
	if (this.mCurrentState != 0 && MSU.getSettingValue(Swifter.ID, "Spin"))
	{
		this.mCurrentRotation += 4 * Math.pow(2, this.mCurrentState - 1);
		if (this.mCurrentRotation >= 360) this.mCurrentRotation -= 360;
		this.mTimeButtons[this.mCurrentState].css('transform', 'rotate(' + this.mCurrentRotation +'deg)')
	}
}

Screens.WorldScreen.mTopbarDatasource.addListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(Screens.WorldScreen.getModule('TopbarDayTimeModule').rotateButtons, Screens.WorldScreen.getModule('TopbarDayTimeModule')));

