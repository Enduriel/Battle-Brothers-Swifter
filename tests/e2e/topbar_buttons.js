// Topbar time buttons: reports each button's box and image, and any pair that overlaps (#175652712).
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
				var x = Math.min(boxes[a].r, boxes[b].r) - Math.max(boxes[a].l, boxes[b].l);
				var y = Math.min(boxes[a].b, boxes[b].b) - Math.max(boxes[a].t, boxes[b].t);
				if (x > 4 && y > 4)
				{
					overlaps.push(boxes[a].n + '/' + boxes[b].n + ' ' + Math.round(x) + 'x' + Math.round(y));
				}
			}
		}
		ClaudeProbe.send('buttons', out.join(' | '));
		ClaudeProbe.send('overlaps', overlaps.length === 0 ? 'none' : overlaps.join(' | '));
	};
	check();
};
