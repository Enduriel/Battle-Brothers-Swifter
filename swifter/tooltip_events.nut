::mods_hookNewObjectOnce("ui/screens/tooltip/tooltip_events", function( o )
{
	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function( _entityId, _elementId, _elementOwner )
	{
		local ret = general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
		if (ret != null) return ret;

		switch (_elementId)
		{
			case "swifter.TimeVeryfastButton":
				return [
					{
						id = 1,
						type = "title",
						text = "Very Fast Speed (" + ::getModSetting(::Swifter.ID, "veryfastTime").getValue() + ")"
					},
					{
						id = 2,
						type = "description",
						text = "Set time to pass much faster than normal. (4x Speed)"
					}
				];

			case "swifter.TimeSuperfastButton":
				return [
					{
						id = 1,
						type = "title",
						text = "Super Fast Speed (" + ::getModSetting(::Swifter.ID, "superfastTime").getValue() + ")"
					},
					{
						id = 2,
						type = "description",
						text = "Set time to pass super quickly. (8x Speed)"
					}
				];
		}
	}
});
