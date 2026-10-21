// Skill movement (teleport, as charge, Lunge, Footwork and the Kraken use) and rising from the ground must follow the
// combat speed like every other animation. Swifter's combat speed calls ::Time.setVirtualSpeed, and the engine already
// runs both on virtual time, so Swifter must not rescale them. Vanilla has no combat speed setting.
// Swifter 1.2.0-1.3.0 divided teleport's speed by the combat speed, which kept those moves at their speed 1 duration;
// PR #2 multiplied it (and divided riseFromGround's _speedMult) by the virtual speed, which applied the speed twice.
// Mods: Modern Hooks, MSU, optionally swifter. Without swifter the probe sets the virtual speed itself, which shows
// the engine's own behaviour. Mode: campaign (starts a small battle against bandits).
//
// Real seconds measured in the original game 1.5.2.3 (2026-10-21); a passing run matches the "no swifter" column
// within a frame or two:
//                            no swifter   swifter 1.3.0   PR #2
//   speed 4 1s real timer    virtual 4.000 (all)
//   speed 1 teleport 2.0     0.267        0.267           0.267
//   speed 4 teleport 2.0     0.084        0.267           0.050
//   speed 1 rise             1.017        1.017           1.017
//   speed 4 rise             0.267        0.267           0.083
::ClaudeProbe.DeferDone = true;
::__speedTiming <- {
	Waited = 0,
	Speeds = [1.0, 4.0],
	Index = 0,
	Bro = null,
	Home = null,
	Away = null,
	T0 = null,
	Polls = 0,

	function log( _k, _v )
	{
		::logInfo("PROBE " + _k + " = " + _v);
	}

	function now()
	{
		return { R = ::Time.getRealTimeF(), V = ::Time.getVirtualTimeF() };
	}

	function since( _t0 )
	{
		local t = ::__speedTiming.now();
		return format("real %.3f virtual %.3f", t.R - _t0.R, t.V - _t0.V);
	}

	function answerIntro( _ )
	{
		local screen = ::World.State.getEventScreen();
		if (screen != null && screen.isVisible()) screen.onButtonPressed(0);
		::Time.scheduleEvent(::TimeUnit.Real, 2500, ::__speedTiming.start, null);
	}

	function start( _ )
	{
		local st = ::World.State;
		local p = st.getLocalCombatProperties(st.getPlayer().getPos());
		p.CombatID = "Event";
		p.IsAutoAssigningBases = false;
		p.Entities = [];
		::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.BanditDefenders, 100, ::Const.Faction.Enemy);
		st.startScriptedCombat(p, false, false, true);
		::Time.scheduleEvent(::TimeUnit.Real, 250, ::__speedTiming.wait, null);
	}

	function wait( _ )
	{
		local self = ::__speedTiming;
		local up = ("State" in ::Tactical) && ::Tactical.State != null && ("Entities" in ::Tactical) && ::Tactical.Entities != null
			&& ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player).len() != 0;
		if (!up && ++self.Waited < 240)
		{
			::Time.scheduleEvent(::TimeUnit.Real, 250, self.wait, null);
			return;
		}
		if (!up)
		{
			self.log("battle", "ERROR the battle never began");
			::ClaudeProbe.done();
			return;
		}
		// let the battle settle (deployment, first turn) before measuring
		::Time.scheduleEvent(::TimeUnit.Real, 3000, self.pickBro, null);
	}

	function pickBro( _ )
	{
		local self = ::__speedTiming;
		try
		{
			foreach (bro in ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player))
			{
				local tile = bro.getTile();
				for (local d = 0; d < 6; d++)
				{
					if (!tile.hasNextTile(d)) continue;
					local next = tile.getNextTile(d);
					if (next.IsEmpty && ::Math.abs(next.Level - tile.Level) <= 1)
					{
						self.Bro = bro;
						self.Home = tile;
						self.Away = next;
						break;
					}
				}
				if (self.Bro != null) break;
			}
			if (self.Bro == null) throw "no brother with a free neighbour";
			self.log("swifter", "Swifter" in ::getroottable() ? ::Swifter.Version : "not loaded");
			self.log("bro tile visible", self.Home.IsVisibleForPlayer);
			self.nextSpeed();
		}
		catch (e)
		{
			self.log("setup", "ERROR " + e);
			::ClaudeProbe.done();
		}
	}

	function setSpeed( _v )
	{
		if ("Swifter" in ::getroottable()) ::Swifter.Mod.ModSettings.getSetting("CombatSpeed").set(_v, false, false);
		::Time.setVirtualSpeed(_v);
	}

	function nextSpeed()
	{
		local self = ::__speedTiming;
		if (self.Index >= self.Speeds.len())
		{
			self.setSpeed(1.0);
			::ClaudeProbe.done();
			return;
		}
		self.setSpeed(self.Speeds[self.Index]);
		self.log("speed " + self.Speeds[self.Index] + " getVirtualSpeed", ::Time.getVirtualSpeed());
		self.T0 = self.now();
		::Time.scheduleEvent(::TimeUnit.Real, 1000, self.afterRate, null);
	}

	function afterRate( _ )
	{
		local self = ::__speedTiming;
		self.log("speed " + self.Speeds[self.Index] + " 1s real timer", self.since(self.T0));
		self.T0 = self.now();
		try
		{
			::Tactical.getNavigator().teleport(self.Bro, self.Away, self.onTeleportDone, null, false, 2.0);
		}
		catch (e)
		{
			self.log("speed " + self.Speeds[self.Index] + " teleport", "ERROR " + e);
			self.rise();
		}
	}

	function onTeleportDone( _entity, _tag )
	{
		local self = ::__speedTiming;
		self.log("speed " + self.Speeds[self.Index] + " teleport 2.0", self.since(self.T0));
		// move back without animation for the next run
		::Time.scheduleEvent(::TimeUnit.Real, 200, function( _ ) {
			::Tactical.getNavigator().teleport(::__speedTiming.Bro, ::__speedTiming.Home, null, null, false);
			::Time.scheduleEvent(::TimeUnit.Real, 500, @(_) ::__speedTiming.rise(), null);
		}, null);
	}

	function rise()
	{
		local self = ::__speedTiming;
		try
		{
			self.Bro.riseFromGround();
			self.log("speed " + self.Speeds[self.Index] + " rise branch", self.Bro.m.IsRaising ? "animated" : "fade");
			self.T0 = self.now();
			self.Polls = 0;
			::Time.scheduleEvent(::TimeUnit.Real, 10, self.pollRise, null);
		}
		catch (e)
		{
			self.log("speed " + self.Speeds[self.Index] + " rise", "ERROR " + e);
			self.Index++;
			self.nextSpeed();
		}
	}

	function pollRise( _ )
	{
		local self = ::__speedTiming;
		if (self.Bro.m.IsRaising && ++self.Polls < 2000)
		{
			::Time.scheduleEvent(::TimeUnit.Real, 10, self.pollRise, null);
			return;
		}
		self.log("speed " + self.Speeds[self.Index] + " rise", (self.Bro.m.IsRaising ? "TIMEOUT " : "") + self.since(self.T0) + " (RenderAnimationSpeed " + self.Bro.m.RenderAnimationSpeed + ")");
		self.Index++;
		::Time.scheduleEvent(::TimeUnit.Real, 300, @(_) ::__speedTiming.nextSpeed(), null);
	}
};
::Time.scheduleEvent(::TimeUnit.Real, 500, ::__speedTiming.answerIntro, null);
