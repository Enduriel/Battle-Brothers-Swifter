// Topbar time buttons: reports each button's box and image, and any pair whose centres are closer than 75% of a
// button's width, i.e. drawn on top of each other (#175652712).
// Run with escort_speed.nut in campaign mode. Passing: "overlaps = none".
// Whichever probe calls ClaudeProbe.done() first ends the run, so this one only sends, and the SQ probe ends it.
// It waits until the world screen is shown (the intro event hides it), which escort_speed.nut's settle phase does.
ClaudeProbe.run = function ()
{
	var tries = 0;
	var check = function ()
	{
		var pause = $('.topbar-daytime-module .l-pause-button');
		if (++tries < 60 && (pause.length === 0 || pause[0].getBoundingClientRect().width === 0))
		{
			setTimeout(check, 500);
			return;
		}
		var names = ['l-pause-button', 'l-normal-time-button', 'l-fast-time-button', 'l-very-fast-time-button', 'l-veryfast-time-button', 'l-superfast-time-button'];
		var boxes = [];
		var out = [];
		for (var i = 0; i < names.length; i++)
		{
			var el = $('.topbar-daytime-module .' + names[i]);
			if (el.length === 0)
			{
				out.push(names[i] + ': absent');
				continue;
			}
			var r = el[0].getBoundingClientRect();
			var img = el.find('img').attr('src') || '';
			boxes.push({ n: names[i], l: r.left, t: r.top, r: r.right, b: r.bottom });
			out.push(names[i] + ': ' + Math.round(r.left) + ',' + Math.round(r.top) + ' ' + Math.round(r.width) + 'x' + Math.round(r.height) + ' ' + img.replace(/^.*\//, ''));
		}
		var overlaps = [];
		for (var a = 0; a < boxes.length; a++)
		{
			for (var b = a + 1; b < boxes.length; b++)
			{
				// the buttons are round and vanilla's own boxes overlap at the corners, so compare centres
				var dx = (boxes[a].l + boxes[a].r - boxes[b].l - boxes[b].r) / 2;
				var dy = (boxes[a].t + boxes[a].b - boxes[b].t - boxes[b].b) / 2;
				var d = Math.sqrt(dx * dx + dy * dy) / (boxes[a].r - boxes[a].l);
				if (d < 0.75)
				{
					overlaps.push(boxes[a].n + '/' + boxes[b].n + ' ' + Math.round(d * 100) + '%');
				}
			}
		}
		ClaudeProbe.send('buttons', out.join(' | '));
		ClaudeProbe.send('overlaps', overlaps.length === 0 ? 'none' : overlaps.join(' | '));
	};
	check();
};
