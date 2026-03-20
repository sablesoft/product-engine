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
- creating a product-local AGENTS entrypoint
- creating a product-local rules layer
- creating an optional workspace-type global rules layer when the workspace model already needs shared defaults
- creating product-local runtime files
- preparing product-local folders for modes, skills, assets, and workspaces
- suggesting minimal engine integration updates when needed

# Read before acting

- `AGENTS.md`
- `state/runtime.yaml`
- `.agents/rules/engine_rules.md`
- `.agents/rules/architecture_rules.md`
- `.agents/rules/skill_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/workspace_rules.md`
- `.agents/rules/naming_rules.md`
- existing `.agents/skills/**`
- existing `products/**`
- existing `products/**/AGENTS.md`
- existing `products/**/rules/**`
- `./assets/product_template.yaml`
- `./assets/product_agents_template.md`
- `./assets/product_rule_template.md`
- `./assets/product_runtime_template.yaml`
- `./assets/product_gitignore_template`
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
    - `products/<product_slug>/AGENTS.md`
    - `products/<product_slug>/product.yaml`
    - `products/<product_slug>/.gitignore`
    - `products/<product_slug>/rules/`
    - `products/<product_slug>/rules/product_rules.md`
    - optional `products/<product_slug>/rules/workspaces/`
    - `products/<product_slug>/modes/`
    - `products/<product_slug>/skills/`
    - `products/<product_slug>/assets/`
    - `products/<product_slug>/state/`
    - `products/<product_slug>/state/runtime.template.yaml`
    - `products/<product_slug>/state/runtime.yaml`
    - `products/<product_slug>/workspaces/`
6. Populate `AGENTS.md` with product-level routing, runtime boundaries, and mode responsibilities.
7. Create the initial product-local rules layer with at least one rule file for domain invariants and boundaries.
8. If the workspace model already implies shared defaults for one workspace type, scaffold `products/<product_slug>/rules/workspaces/` and add the minimal matching rule files.
9. Populate `product.yaml` from the local template with only the fields needed to describe the product contract.
10. Populate product runtime files from the local runtime template with only resumable context fields that fit the product.
11. Prefer product-specific pointer names that match the workspace ontology, such as `active_world_slug` or `active_adventure_slug`, instead of forcing a generic field name.
12. Add product-local notes or placeholder files only when they clearly help the next step.
13. Update engine-level routing or references only if the new product requires them immediately.

# Constraints

- do not duplicate engine rules inside the product
- do not invent product-specific modes unless the user asked for them or they are necessary for the scaffold
- keep the scaffold minimal and extensible
- keep all engine-side instructions and examples in engine_language
- do not move product-specific logic into `.agents/skills/`
- do not store canonical product data or full workspace state in product runtime
- do not duplicate engine root policy when a product-local instruction can reference or narrow it
- do not ship a product without a product-local rules layer

# Output

1. created product files and folders
2. initial product contract
3. short note on the next recommended step
