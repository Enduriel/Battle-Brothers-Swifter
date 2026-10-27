# Changelog

## Unreleased

- Removed Swifter's fix for events being rarer at higher world speeds, because vanilla now fixes this itself. With both, event checks at high speed did several times more work per frame than needed.

## 1.3.1 - 2026-10-21

- Fixed charges, Lunge, Footwork, the Kraken's tentacles and other skills that move a character ignoring the combat speed. They now follow the combat speed like every other animation.

## 1.3.0 - 2026-10-21

- Now requires Battle Brothers 1.5.2.2 or later, MSU 1.2.0 or later and [Modern Hooks](https://www.nexusmods.com/battlebrothers/mods/685), which replaces the old modding script hooks.
- MSU now tells you in-game when a Swifter update is out, with links to GitHub and Nexus.
- Fixed the Barbarian King "Untoward March" and greenskin siege contracts breaking with Battle Brothers 1.5.2.2, and caravan escorts breaking when combined with other mods' fixes.
- Swifter now uses vanilla's own 4x button and key instead of adding a second, overlapping one, and adds only the 8x button (key 4) on top.
- Escort and camping speeds now follow vanilla's (escorts at least 3.75x, camping at least 3x). 4x and 8x can still be chosen while camping or escorting.
- Combat speed now also speeds up skills that move a character, such as Footwork, Lunge, charges and the Kraken's tentacles moving. This may fix crashes in the Kraken fight at high combat speeds.
