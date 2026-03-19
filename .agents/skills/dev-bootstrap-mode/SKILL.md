---
name: dev-bootstrap-mode
description: Use this skill when the user wants to create a new mode inside an existing product, scaffold product-local mode files, or define a new product workflow entry point. Triggers on requests like "create mode", "add mode", "bootstrap mode", "add editor mode", "add player mode", "create research mode".
---

# Purpose

Create new product-local modes in a consistent, engine-compatible way.

This includes:
- defining the mode contract
- creating product-local mode files
- preparing mode-local skills and assets folders
- updating the product manifest when needed
- suggesting the next product-specific workflow step

# Read before acting

- `AGENTS.md`
- `state/runtime.yaml`
- `.agents/rules/engine_rules.md`
- `.agents/rules/architecture_rules.md`
- `.agents/rules/skill_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/naming_rules.md`
- existing `.agents/skills/**`
- existing `products/**`
- `./assets/mode_template.yaml`
- `./assets/mode_structure_checklist.md`

# Behavior

1. Understand which product the mode belongs to.
2. Check whether the requested workflow should be a new mode and not just a new product-local skill.
3. Define:
    - product slug
    - mode name
    - purpose
    - responsibilities
    - boundaries
    - initial skills
4. Ensure `products/<product_slug>/` exists.
5. Create the minimal mode scaffold:
    - `products/<product_slug>/modes/<mode_name>.yaml`
    - `products/<product_slug>/skills/<mode_name>/`
    - `products/<product_slug>/skills/<mode_name>/assets/`
6. Populate the mode contract from the local template with only the fields needed for initial routing and responsibility boundaries.
7. Update `products/<product_slug>/product.yaml` if the new mode should be declared in the product manifest.
8. Add placeholder assets or notes only when they clearly help the next product-specific step.

# Constraints

- do not create product-local modes outside `products/<product_slug>/`
- do not duplicate engine routing logic inside product files
- do not invent extra modes when one is enough
- keep the scaffold minimal and extensible
- keep all engine-side instructions and examples in engine_language

# Output

1. created or updated product-local mode files
2. updated product contract when needed
3. short note on the next recommended step
