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
- creating a product-local rules layer
- creating `rules/workspace/.gitkeep` as the local scope-rules anchor
- creating an optional all-workspace global rule file when the product needs shared defaults across every workspace
- preparing `rules/workspace/` as the product-local area for any workspace or entity-specific working rules
- creating product-local runtime files
- preparing product-local folders for modes, skills, assets, and workspace content
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
- `.agents/skills/dev-bootstrap-product/assets/product_template.yaml`
- `.agents/skills/dev-bootstrap-product/assets/product_agents_template.md`
- `.agents/skills/dev-bootstrap-product/assets/toolkit_product_readme_template.md`
- `.agents/skills/dev-bootstrap-product/assets/product_rule_template.md`
- `.agents/skills/dev-bootstrap-product/assets/product_runtime_template.yaml`
- `.agents/skills/dev-bootstrap-product/assets/product_gitignore_template`
- `.agents/skills/dev-bootstrap-product/assets/product_structure_checklist.md`

# Behavior

1. Understand what kind of product the user wants to create.
2. Check whether this should be a product and not just a new engine-native skill.
3. Define:
    - slug
    - profile
    - purpose
    - scope
    - initial modes
    - expected workspace entities
    - initial installable skills when the profile is `toolkit`
    - initial per-skill versions when the profile is `toolkit`
4. Create `products/<product_slug>/`.
5. Create the minimal product scaffold:
    - `products/<product_slug>/product.yaml`
6. For an embedded product, also create:
    - `products/<product_slug>/AGENTS.md`
    - `products/<product_slug>/.gitignore`
    - `products/<product_slug>/rules/`
    - `products/<product_slug>/rules/product_rules.md`
    - `products/<product_slug>/rules/workspace/`
    - `products/<product_slug>/rules/workspace/.gitkeep`
    - `products/<product_slug>/modes/`
    - `products/<product_slug>/skills/`
    - `products/<product_slug>/assets/`
    - `products/<product_slug>/state/`
    - `products/<product_slug>/state/runtime.template.yaml`
    - `products/<product_slug>/state/runtime.yaml`
    - `products/<product_slug>/workspace/`
7. For a toolkit product, instead create:
    - `products/<product_slug>/README.md`
    - one or more installable skill folders directly under `products/<product_slug>/`
    - each skill folder with its own self-contained `SKILL.md` and bundled resources
8. Populate `README.md` for toolkit products with purpose, installation examples for `skill-installer`, and host-project temporary artifact expectations.
9. Create the initial product-local rules layer only for embedded products or when a toolkit has a strong engine-authoring reason to keep product-wide rules.
10. Scaffold `products/<product_slug>/rules/workspace/` only when the product actually uses workspace-scoped rules.
11. Populate `product.yaml` from the local template with only the fields needed to describe the product contract.
12. For toolkit products, include the shipped skill list in `product.yaml` and create a `VERSION` file inside each installable skill folder.
13. For toolkit products, omit `mode_namespace` unless the user has a very specific reason to keep it.
14. Populate product runtime files from the local runtime template only for profiles that truly use resumable product-local context.
15. Prefer product-specific pointer names that match the workspace ontology, such as `active_world_slug` or `active_adventure_slug`, instead of forcing a generic field name.
16. Add product-local notes or placeholder files only when they clearly help the next step.
17. Update engine-level routing or references only if the new product requires them immediately.

# Constraints

- do not duplicate engine rules inside the product
- do not invent product-specific modes unless the user asked for them or they are necessary for the scaffold
- keep the scaffold minimal and extensible
- keep all engine-side instructions and examples in engine_language
- do not move product-specific logic into `.agents/skills/`
- do not store canonical product data or full workspace state in product runtime
- do not duplicate engine root policy when a product-local instruction can reference or narrow it
- do not ship an embedded product without a product-local rules layer
- ensure embedded products ignore local files under `rules/workspace/` while preserving `rules/workspace/.gitkeep`
- do not force `AGENTS.md`, `rules/`, `workspace/`, `modes/`, `state/`, or shared top-level support folders onto toolkit products
- toolkit products must be shaped so each shipped skill can be installed by `skill-installer` without relying on sibling shared folders

# Output

1. created product files and folders
2. initial product contract
3. short note on the next recommended step
