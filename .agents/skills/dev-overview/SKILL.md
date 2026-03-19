---
name: dev-overview
description: Use this skill when the user wants to understand the current architecture, structure, modes, layers, or identify missing parts or design gaps. Triggers on requests like "how is this structured", "what do we have", "what is missing", "map the architecture", "what did we forget".
---

# Purpose

Provide a clear, structured overview of the current engine state.

Explain:
- architecture
- layers
- modes
- skills
- runtime model

Identify:
- missing pieces
- inconsistencies
- weak points

# Read before acting

- `AGENTS.md`
- `state/runtime.template.yaml`
- `.agents/rules/engine_rules.md`
- `.agents/rules/architecture_rules.md`
- `.agents/rules/runtime_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/layer_rules.md`
- `.agents/rules/skill_rules.md`
- `.agents/skills/**` (names and structure)
- `products/**` (when present)
- `./assets/repo_map.md`
- `./assets/mode_model.md`

# Behavior

1. Reconstruct the current system:
    - modes
    - layers
    - runtime
    - skills

2. Describe it clearly.

3. Identify gaps:
    - missing skills
    - unclear boundaries
    - duplicated responsibility
    - overgrown AGENTS
    - drift between rules and implementation

4. Suggest improvements:
    - minimal
    - concrete
    - no unnecessary rewrites

# Constraints

- do not modify files
- do not invent systems not grounded in the current repo
- keep explanations structured

# Output

- short system overview
- list of issues
- list of suggested improvements
