---
name: play-turn
description: Use this skill for normal gameplay after the adventure and player character are already created. Triggers on player actions like "осматриваюсь", "иду в порт", "говорю с трактирщиком", "вру стражнику", "обыскиваю комнату", "что я вижу?", and other in-session actions. Do not use for initial world bootstrap or initial character creation.
---

# Purpose

This skill runs one normal game turn.

It must:
1. Read the current state.
2. Resolve the player's attempted action.
3. Reply as the Game Master.
4. Persist the consequences to files.

# Read before every turn

Always read:

- `AGENTS.md`
- `state/runtime.yaml`
- `assets/current_scene_template.md`
- `assets/event_template.md`
- `assets/session_log_template.md`
- `assets/location_card_template.md`
- `assets/quest_card_template.md`
- `assets/faction_card_template.md`
- `assets/race_card_template.md`
- `adventures/<active_slug>/canon/setting.md`
- `adventures/<active_slug>/canon/global_story.md`
- `adventures/<active_slug>/canon/tone_and_themes.md`
- `adventures/<active_slug>/canon/rules_of_world.md`
- `adventures/<active_slug>/characters/player.md`
- `adventures/<active_slug>/scenes/current_scene.md`
- `adventures/<active_slug>/state/campaign_state.yaml`
- `adventures/<active_slug>/state/facts.yaml`
- `adventures/<active_slug>/state/flags.yaml`
- current session log in `adventures/<active_slug>/sessions/` if present
- recent files in `adventures/<active_slug>/events/`
- directly relevant NPC, location, quest, faction, and race cards

# Resume behavior

If the turn appears to be the first interaction after loading an existing adventure:

- briefly summarize the current situation based on:
    - `adventures/<active_slug>/scenes/current_scene.md`
    - recent files in `adventures/<active_slug>/events/`
- re-establish immediate context for the player
- then continue normally

# Turn procedure

## Step 1: Interpret action

Interpret what the player is trying to do:
- observe
- move
- talk
- deceive
- investigate
- take
- threaten
- rest
- improvise
- something else

If the request is ambiguous but still playable, choose the most reasonable interpretation and continue.

## Step 2: Resolve consequences

Decide:
- what happens immediately
- whether there is cost, risk, or complication
- whether world state changes
- whether a new NPC, location, clue, quest, faction, or race becomes important

Be consistent with canon and prior events.

If a group, alliance, people, culture, species, or political force becomes relevant enough to affect future play, treat it as a real world entity and persist it as a card rather than leaving it as a throwaway mention.

## Step 3: Reply as GM

Write:
1. a concise narrative response
2. immediate visible outcome
3. if needed, a question or tension point
4. 2 to 4 obvious possible next directions

Do not dump internal file logic into the chat.

## Step 4: Persist state

After every significant action:

1. Create a new event file in:
    - `adventures/<active_slug>/events/`
2. Update:
    - `adventures/<active_slug>/scenes/current_scene.md`
    - `adventures/<active_slug>/state/campaign_state.yaml`
    - `adventures/<active_slug>/state/flags.yaml` when needed
    - a readable session log under `adventures/<active_slug>/sessions/` by appending a short narrative beat for the turn
3. If a new important entity appears, create its card using the relevant assets and established adventure card structure:
    - NPC
    - location
    - quest
    - faction
    - race

## Entity creation guidance

Create a faction card when:
- an organized group has goals, methods, influence, or recurring relevance
- the player joins, opposes, bargains with, or investigates that group
- the group is likely to matter again later

Create a race card when:
- a species, people, ancestry, or culture becomes important to the world or plot
- the player meets members whose identity affects politics, customs, conflict, or access
- the race is likely to matter again later

Do not create cards for one-off background mentions with no likely future relevance.

# Event numbering

Use zero-padded increasing numbers:
- `0001_...`
- `0002_...`
- `0003_...`

# Writing rules

- The files are the source of truth.
- Do not retcon established facts casually.
- Keep the reply vivid but not bloated.
- Always leave the player with a sense of actionable next steps.
- The session log should preserve the adventure as a readable story, not only as state transitions.
