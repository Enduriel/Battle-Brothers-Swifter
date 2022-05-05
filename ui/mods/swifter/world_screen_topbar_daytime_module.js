Swifter.WorldScreenTopbarDayTimeModule_updateButtons = WorldScreenTopbarDayTimeModule.prototype.updateButtons;
WorldScreenTopbarDayTimeModule.prototype.updateButtons = function (_state)
{
	Swifter.WorldScreenTopbarDayTimeModule_updateButtons.call(this, _state);
	this.mTimePauseButton.changeButtonImage(Path.GFX + (_state == 0 ? Swifter.Asset.BUTTON_PAUSE : Swifter.Asset.BUTTON_PAUSE_DISABLED));
	this.mTimeNormalButton.changeButtonImage(Path.GFX + (_state == 1 ? Swifter.Asset.BUTTON_PLAY : Swifter.Asset.BUTTON_PLAY_DISABLED));
	this.mTimeFastButton.changeButtonImage(Path.GFX + (_state == 2 ? Swifter.Asset.BUTTON_FAST_FORWARD : Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED));
	this.mTimeVeryfastButton.changeButtonImage(Path.GFX + (_state == 3 ? Swifter.Asset.BUTTON_VERYFAST : Swifter.Asset.BUTTON_VERYFAST_DISABLED));
	this.mTimeSuperfastButton.changeButtonImage(Path.GFX + (_state == 4 ? Swifter.Asset.BUTTON_SUPERFAST : Swifter.Asset.BUTTON_SUPERFAST_DISABLED));
}

Swifter.WorldScreenTopbarDayTimeModule_createDIV = WorldScreenTopbarDayTimeModule.prototype.createDIV;
WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
{
	this.mTimeVeryfastButton = null;
	this.mTimeSuperfastButton = null;
	Swifter.WorldScreenTopbarDayTimeModule_createDIV.call(this, _parentDiv);
	var self = this;

	var layout = $('<div class="l-veryfast-time-button"/>');
	this.mContainer.append(layout);
	this.mTimeVeryfastButton = layout.createImageButton(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED, function ()
	{
		self.notifyBackendTimeVeryfastButtonPressed();

		self.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_VERYFAST);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED);
	}, '', 10);

	layout = $('<div class="l-superfast-time-button"/>');
	this.mContainer.append(layout);
	this.mTimeSuperfastButton = layout.createImageButton(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED, function ()
	{
		self.notifyBackendTimeSuperfastButtonPressed();

		self.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST);
	}, '', 10);

	this.mTimePauseButton.on("click", function()
	{
		self.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED);
	});
	this.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE);

	this.mTimeNormalButton.on("click", function()
	{
		self.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED);
	});
	this.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);

	this.mTimeFastButton.on("click", function()
	{
		self.mTimePauseButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_SUPERFAST_DISABLED);
	});
	this.mTimeFastButton.changeButtonImage(Path.GFX + Swifter.Asset.BUTTON_FAST_FORWARD_DISABLED);
}

Swifter.WorldScreenTopbarDayTimeModule_bindTooltips = WorldScreenTopbarDayTimeModule.prototype.bindTooltips;
WorldScreenTopbarDayTimeModule.prototype.bindTooltips = function ()
{
	Swifter.WorldScreenTopbarDayTimeModule_bindTooltips.call(this);

	this.mTimeVeryfastButton.bindTooltip({ contentType: 'ui-element', elementId: Swifter.TooltipIdentifier.TimeVeryfastButton });
	this.mTimeSuperfastButton.bindTooltip({ contentType: 'ui-element', elementId: Swifter.TooltipIdentifier.TimeSuperfastButton });
};

Swifter.WorldScreenTopbarDayTimeModule_unbindTooltips = WorldScreenTopbarDayTimeModule.prototype.unbindTooltips;
WorldScreenTopbarDayTimeModule.prototype.unbindTooltips = function ()
{
	Swifter.WorldScreenTopbarDayTimeModule_unbindTooltips.call(this);

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
