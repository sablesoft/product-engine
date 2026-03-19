---
name: dev-bootstrap-product
description: Use this skill when the user wants to create a new product package, introduce a product layer on top of the engine, or scaffold a product with its own modes and skills. Triggers on requests like "create product", "add product", "bootstrap product", "scaffold a new product", "introduce writer studio", "add gm product".
---

# Purpose

Create new products in a consistent, engine-compatible way.

This includes:
- defining the product slug and responsibility
- creating the product scaffold
- creating the product manifest
- preparing product-local folders for modes, skills, assets, and workspaces
- suggesting minimal engine integration updates when needed

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
- `./assets/product_template.yaml`
- `./assets/product_structure_checklist.md`

# Behavior

1. Understand what kind of product the user wants to create.
2. Check whether this should be a product and not just a new engine-native skill.
3. Define:
    - slug
    - purpose
    - scope
    - initial modes
    - expected workspaces
4. Create `products/<product_slug>/`.
5. Create the minimal product scaffold:
    - `products/<product_slug>/product.yaml`
    - `products/<product_slug>/modes/`
    - `products/<product_slug>/skills/`
    - `products/<product_slug>/assets/`
    - `products/<product_slug>/workspaces/`
6. Populate `product.yaml` from the local template with only the fields needed to describe the product contract.
7. Add product-local notes or placeholder files only when they clearly help the next step.
8. Update engine-level routing or references only if the new product requires them immediately.

# Constraints

- do not duplicate engine rules inside the product
- do not invent product-specific modes unless the user asked for them or they are necessary for the scaffold
- keep the scaffold minimal and extensible
- keep all engine-side instructions and examples in engine_language
- do not move product-specific logic into `.agents/skills/`

# Output

1. created product files and folders
2. initial product contract
3. short note on the next recommended step
