---
name: dev-bootstrap-skill
description: Use this skill when the user wants to create a new engine-native skill, extend the engine with a new capability, or define a new engine workflow. Triggers on requests like "create new skill", "add skill", "introduce new workflow", "bootstrap skill", "add dev skill", "add engine skill".
---

# Purpose

Create new engine-native skills in a consistent, scalable way.

This includes:
- defining new workflows
- creating or updating SKILL.md files
- suggesting required assets
- integrating the skill into the engine when needed

# Read before acting

- `AGENTS.md`
- `.agents/rules/engine_rules.md`
- `.agents/rules/architecture_rules.md`
- `.agents/rules/skill_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/naming_rules.md`
- existing `.agents/skills/**`
- `./assets/skill_template.md`
- `./assets/asset_template.md`
- `./assets/skill_design_checklist.md`

# Behavior

1. Understand the requested workflow.
2. Check whether a new engine-native skill is really needed.
3. Define:
    - name
    - mode
    - responsibility
    - boundaries
4. Create or update the minimal set of engine files needed for the skill.
5. Add assets only if they are clearly needed.
6. Update AGENTS routing only if the new skill changes routing behavior.

# Constraints

- do not duplicate existing skills
- do not duplicate AGENTS logic inside a skill
- do not violate engine rules
- do not use this workflow for product-local skills
- keep all engine-side examples and instructions in engine_language

# Output

1. created or updated engine files
2. optional assets when justified
3. short integration note
