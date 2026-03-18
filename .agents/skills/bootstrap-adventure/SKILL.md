---
name: bootstrap-adventure
description: Use this skill when the user wants to start a new adventure, asks to propose adventure ideas, chooses one of the proposed adventures, or gives setting/tone wishes for a new campaign. Triggers on requests like "предложи приключение", "дай варианты приключения", "хочу приключение в духе...", "беру второй вариант", "создай базу приключения". Do not use for character creation or normal in-session play.
---

# Purpose

This skill handles the full adventure bootstrap flow in two substeps:

1. Propose 3 adventure options.
2. After the user chooses one option, create the initial adventure files.

All concrete adventures live under `adventures/<slug>/`.

# Before doing anything

1. Read `state/runtime.yaml`.
2. Find the active adventure slug if it exists.
3. If there is no active slug and the user is starting a new adventure, create a slug from the chosen or proposed title later.
4. Read:
   - `AGENTS.md`
   - `assets/adventure_option_template.md`
   - `assets/adventure_card_template.md`
   - `assets/location_card_template.md`
   - `assets/quest_card_template.md`
   - `assets/setting_template.md`
   - `assets/global_story_template.md`
   - `assets/tone_and_theme_template.md`
   - `assets/rules_of_world_template.md`
   - `assets/campaign_state_template.yaml`
   - `assets/facts_template.yaml`
   - `assets/flags_template.yaml`

# When user asks to propose adventure options

If the user asks for a new adventure, but has not selected one yet:

1. Generate exactly 3 distinct adventure options.
2. Make them meaningfully different by:
   - tone
   - core conflict
   - starting situation
   - risk level
3. Keep each option compact and easy to choose from.
4. Ensure folder exists:
   - `adventures/_bootstrap/`
5. Write the options to:
   - `adventures/_bootstrap/adventure_options.md`
6. Update `state/runtime.yaml` so that:
   - `phase: bootstrap_adventure`
   - `active_adventure_slug: null`
   - `adventure.options_ready: true`
   - `adventure.selected_option: null`

## Required option format

For each option include:

- title
- one-sentence premise
- tone
- starting situation
- main threat
- why this option is interesting

# When user chooses an option

If the user clearly selects an option and possibly adds preferences:

1. Determine or create `adventure_slug`.
2. Create folder:
   - `adventures/<adventure_slug>/`
3. Create the initial structure:
   - `adventures/<adventure_slug>/_bootstrap/`
   - `adventures/<adventure_slug>/canon/`
   - `adventures/<adventure_slug>/canon/setting.md`
   - `adventures/<adventure_slug>/canon/global_story.md`
   - `adventures/<adventure_slug>/canon/tone_and_themes.md`
   - `adventures/<adventure_slug>/canon/rules_of_world.md`
   - `adventures/<adventure_slug>/characters/`
   - `adventures/<adventure_slug>/characters/npcs/`
   - `adventures/<adventure_slug>/locations/`
   - `adventures/<adventure_slug>/quests/`
   - `adventures/<adventure_slug>/quests/active/`
   - `adventures/<adventure_slug>/quests/completed/`
   - `adventures/<adventure_slug>/scenes/`
   - `adventures/<adventure_slug>/events/`
   - `adventures/<adventure_slug>/sessions/`
   - `adventures/<adventure_slug>/state/`
   - `adventures/<adventure_slug>/state/campaign_state.yaml`
   - `adventures/<adventure_slug>/state/facts.yaml`
   - `adventures/<adventure_slug>/state/flags.yaml`
4. Create at minimum:
   - 3 location cards
   - 2 active quest cards
   - 1 initial event file
5. Do not create player character yet.
6. Update `state/runtime.yaml` so that:
   - `active_adventure_slug: <adventure_slug>`
   - `phase: bootstrap_character`
   - `adventure.selected_option` reflects the chosen option
7. Ensure the created world is immediately playable.

# Writing rules

- Use the templates from this skill's `assets/` directory.
- If the user gave extra wishes, incorporate them without rewriting the selected option beyond recognition.
- Prefer small but playable bootstrap content over huge lore dumps.
- The created world must contain enough material for immediate play.

# Output rules

After proposing options:
- Show the 3 options in chat.
- Ask the user to choose one naturally.

After creating the adventure base:
- Briefly confirm the adventure title and theme.
- Then move the user toward character creation naturally.
