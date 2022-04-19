Quicker.WorldScreenTopbarDayTimeModule_updateButtons = WorldScreenTopbarDayTimeModule.prototype.updateButtons;
WorldScreenTopbarDayTimeModule.prototype.updateButtons = function (_state)
{
	Quicker.WorldScreenTopbarDayTimeModule_updateButtons.call(this, _state);
	this.mTimePauseButton.changeButtonImage(Path.GFX + (_state == 0 ? Asset.BUTTON_PAUSE : Asset.BUTTON_PAUSE_DISABLED));
	this.mTimeNormalButton.changeButtonImage(Path.GFX + (_state == 1 ? Asset.BUTTON_PLAY : Asset.BUTTON_PLAY_DISABLED));
	this.mTimeFastButton.changeButtonImage(Path.GFX + (_state == 2 ? Asset.BUTTON_FAST_FORWARD : Asset.BUTTON_FAST_FORWARD_DISABLED));
	this.mTimeVeryfastButton.changeButtonImage(Path.GFX + (_state == 3 ? Quicker.Asset.BUTTON_VERYFAST : Quicker.Asset.BUTTON_VERYFAST_DISABLED));
	this.mTimeSuperfastButton.changeButtonImage(Path.GFX + (_state == 4 ? Quicker.Asset.BUTTON_SUPERFAST : Quicker.Asset.BUTTON_SUPERFAST_DISABLED));
}

Quicker.WorldScreenTopbarDayTimeModule_createDIV = WorldScreenTopbarDayTimeModule.prototype.createDiv;
WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
{
	Quicker.WorldScreenTopbarDayTimeModule_createDIV.call(this, _parentDiv);
	var self = this;

	var layout = $('<div class="l-time-veryfast-button"/>');
	this.mContainer.append(layout);
	this.mTimeVeryfastButton = layout.createImageButton(Path.GFX + Quicker.BUTTON_VERYFAST_DISABLED, function ()
	{
		self.notifyBackendTimeVeryfastButtonPressed();

		self.mTimePauseButton.changeButtonImage(Path.GFX + Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_VERYFAST);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_SUPERFAST_DISABLED);
	}, '', 10);

	var layout = $('<div class="l-time-superfast-button"/>');
	this.mContainer.append(layout);
	this.mTimeSuperfastButton = layout.createImageButton(Path.GFX + Quicker.BUTTON_SUPERFAST_DISABLED, function ()
	{
		self.notifyBackendTimeSuperfastButtonPressed();

		self.mTimePauseButton.changeButtonImage(Path.GFX + Asset.BUTTON_PAUSE_DISABLED);
		self.mTimeNormalButton.changeButtonImage(Path.GFX + Asset.BUTTON_PLAY_DISABLED);
		self.mTimeFastButton.changeButtonImage(Path.GFX + Asset.BUTTON_FAST_FORWARD_DISABLED);
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_SUPERFAST);
	}, '', 10);

	this.mTimePauseButton.on("click", function()
	{
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_SUPERFAST_DISABLED);
	});

	this.mTimeNormalButton.on("click", function()
	{
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_SUPERFAST_DISABLED);
	});

	this.mTimeFastButton.on("click", function()
	{
		self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_VERYFAST_DISABLED);
		self.mTimeSuperfastButton.changeButtonImage(Path.GFX + Quicker.Asset.BUTTON_SUPERFAST_DISABLED);
	});
}

Quicker.WorldScreenTopbarDayTimeModule_bindTooltips = WorldScreenTopbarDayTimeModule.prototype.bindTooltips;

WorldScreenTopbarDayTimeModule.prototype.bindTooltips = function ()
{
	Quicker.WorldScreenTopbarDayTimeModule_bindTooltips.call(this);

	this.mTimeVeryfastButton.bindTooltip({ contentType: 'ui-element', elementId: Quicker.TooltipIdentifier.TimeVeryfastButton });
	this.mTimeSuperfastButton.bindTooltip({ contentType: 'ui-element', elementId: Quicker.TooltipIdentifier.TimeSuperfastButton });
};

Quicker.WorldScreenTopbarDayTimeModule_unbindTooltips = WorldScreenTopbarDayTimeModule.prototype.unbindTooltips;
WorldScreenTopbarDayTimeModule.prototype.bindTooltips = function ()
{
	Quicker.WorldScreenTopbarDayTimeModule_unbindTooltips.call(this);

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
