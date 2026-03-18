---
name: bootstrap-character
description: Use this skill when the adventure already exists and the user asks to create a player character, asks for character ideas, selects one of the proposed archetypes, or adds preferences to the player character. Triggers on requests like "создай персонажа", "предложи персонажа", "хочу играть за...", "беру бывшего писаря", "добавь долг перед опасными людьми". Do not use for creating the adventure world or for regular GM turn resolution.
---

# Purpose

This skill handles player-character bootstrap:

1. Propose 3 player-character options that fit the chosen adventure.
2. After the user chooses one, create `characters/player.md` and update runtime and campaign state.
3. Optionally propose 2 to 3 entry scenes if they do not exist yet.
4. If the user chooses an entry scene, create `scenes/current_scene.md` and transition into play.

# Before doing anything

Read:

- `AGENTS.md`
- `state/runtime.yaml`
- `assets/character_option_template.md`
- `assets/player_character_card_template.md`
- `assets/entry_scene_option_template.md`
- `adventures/<active_slug>/canon/setting.md`
- `adventures/<active_slug>/canon/global_story.md`
- `adventures/<active_slug>/canon/tone_and_themes.md`
- `adventures/<active_slug>/locations/`
- `adventures/<active_slug>/quests/active/`

# Preconditions

This skill assumes:
- the active adventure already exists
- phase is `bootstrap_character` or equivalent
- player character has not been fully created yet, or entry scene has not yet been chosen

# When user asks for character options

1. Generate exactly 3 character options.
2. Every option must fit the existing world and opening conflicts.
3. Make the options different by:
   - social position
   - competence
   - vulnerability
   - relationship to the setting
4. Ensure folder exists:
   - `adventures/<active_slug>/_bootstrap/`
5. Save them to:
   - `adventures/<active_slug>/_bootstrap/character_options.md`

## Required option format

For each option include:

- name or placeholder name
- role
- archetype
- one-paragraph backstory
- 2 strengths
- 2 weaknesses
- 1 personal complication
- why this character is interesting in this adventure

# When user chooses a character

1. Create:
   - `adventures/<active_slug>/characters/player.md`
2. Update:
   - `state/runtime.yaml`
   - `adventures/<active_slug>/state/campaign_state.yaml`
3. If no entry scene exists yet, propose 2 or 3 starting scenes using `assets/entry_scene_option_template.md`.
4. If the user already chose an entry scene, create:
   - `adventures/<active_slug>/scenes/current_scene.md`
5. Set phase in `state/runtime.yaml` to:
   - `bootstrap_character` if entry scene still has not been chosen
   - `play` if current scene was created

# Writing rules

- Respect explicit user wishes over default archetypes.
- Do not create an overpowered character.
- Build hooks that connect the player to at least one location or quest.
- Make the character playable immediately.

# Output rules

After proposing character options:
- Show the 3 options in chat.
- Ask the user to pick one.

After creating the player:
- Summarize the character briefly.
- If needed, offer entry scenes.
- If entry scene already exists, begin play naturally.
