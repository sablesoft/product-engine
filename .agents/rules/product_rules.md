# Product Rules

## Product model

- a product is a first-class engine extension unit
- each product lives under `products/<product_slug>/`
- each product owns its own manifest and product-scoped implementation files
- a product may use one of two profiles:
  - embedded product
  - toolkit product

## Required product contract

Each product must define:

- `products/<product_slug>/product.yaml`

Each embedded product must define:

- `products/<product_slug>/AGENTS.md`
- `products/<product_slug>/rules/`

Each toolkit product must define:

- `products/<product_slug>/README.md`
- one or more installable skill folders directly under `products/<product_slug>/`

Each product must declare in `product.yaml`:

- its `profile`
- its distribution model

Embedded products should also declare:

- `mode_namespace`

Toolkit products should also declare:

- the installable skill folders they ship
- no per-skill version map is required in `product.yaml`

## Product instruction resolution

- embedded products use `products/<product_slug>/AGENTS.md` as their product-local instruction entrypoint
- do not assume toolkit products expose a product-level instruction entrypoint at all
- toolkit products are designed to ship installable skills rather than a secondary AGENTS layer
- when documenting a toolkit product, use `README.md` as the human-facing entrypoint

The product contract may define:

- product identity
- purpose and scope
- product-local mode namespace
- workspace contract
- distribution and installation behavior

## Product profiles

### Embedded product

- this is the default engine-native product profile
- it may define product-local modes, runtime, workspace, and product-local `AGENTS.md`
- it follows the ordinary engine routing model
- it should declare `mode_namespace` in `product.yaml`

### Toolkit product

- a toolkit product is a portable repository of installable Codex skills
- it must be designed for installation through `skill-installer`
- it must stay usable without bringing the whole `product-engine` repository into that host project
- it must not rely on project-local `.agents/skills/` discovery
- it must not require engine runtime, product runtime, product modes, or product workspace to function
- each installable skill must live in its own top-level folder directly under `products/<product_slug>/`
- each installable skill folder must be self-contained according to `skill-creator` and `skill-installer` expectations
- toolkit products should not depend on shared product-level `references/`, `templates/`, `assets/`, `scripts/`, or `adapters/` folders outside the individual skill folders
- toolkit products should assume the host project uses a root `tmp/` directory and should write temporary artifacts under a product-specific subdirectory such as `tmp/<product_slug>/`
- toolkit products should be documented for humans in `products/<product_slug>/README.md`, including installation examples for `skill-installer`
- each shipped installable skill should keep its own version in a `VERSION` file inside that skill folder
- toolkit products should use semantic versioning in each skill's `VERSION` file
- keep the same skill name across releases
- do not rename installable skills
- toolkit products may omit `mode_namespace` entirely

Toolkit products are still products for authoring purposes inside `product-engine`, but their shipping contract is a skill-installer-ready multi-skill repository rather than an engine-routed product package.

## Workspace

- `workspace` defines the product workspace root and the product-specific entity ontology inside it
- `workspace` does not store live runtime state
- product content lives under the product workspace root
- each product entity should represent one concrete domain work container
- product entities may be:
    - canonical entity repositories such as worlds, characters, books, or contacts
    - stateful run repositories such as adventures, sessions, draft runs, or deal cycles

## Workspace boundary

- use `product.yaml` to define the available workspace ontology
- use `products/<product_slug>/workspace/` to store concrete product content and entity roots
- do not store active workspace progress in `product.yaml`
- do not use engine runtime as a substitute for the product workspace
- toolkit products should omit `workspace` entirely
- product-local authoring modes such as `master` should govern workspace content and product-local scoped workspace rules under `rules/workspace/`; they should not mutate engine or broader product contracts unless the user switches to `dev`
- if a user asks for engine or broader product contract changes while resolved into a product-local mode, the request should be redirected to `dev` rather than fulfilled in that product-local mode
- if a product needs rules for every workspace regardless of type, it may keep them in `products/<product_slug>/rules/workspace/global.md`
- if a product needs local working rules for concrete worlds, adventures, scenarios, characters, quests, or similar product entities, keep them under `products/<product_slug>/rules/workspace/`

## Product runtime

- a product may define its own runtime under `products/<product_slug>/state/runtime.yaml`
- product runtime stores resumable product-local context between sessions
- product runtime pointer field names are product-specific and should follow the product ontology
- product runtime may include:
    - `last_mode`
    - active world, scenario, character, or similar entity pointers
    - active run pointers such as adventure, session, or draft-run
    - timestamps or lightweight continuity metadata
- use specific pointer names such as `active_world_slug` or `active_adventure_slug` when they improve clarity
- use a generic field such as `active_workspace_slug` only when the product does not need more specific pointers yet
- product runtime must not store full workspace content
- product runtime must not store canonical product contracts
- product runtime must not replace workspace state as the source of truth
- toolkit products should omit product runtime

## Runtime interplay

- use engine runtime for the product and mode that are active now
- use product runtime for the last known local context of that product
- if the active product is restored, engine runtime may be initialized from product runtime
- when a product is active, engine runtime and product runtime may temporarily point to the same mode, but they do not have the same responsibility

## Product-local rules

A embedded product must define product-local rules under:
- `products/<product_slug>/rules/`

Product-local rules may constrain:
- product modes
- product workspace and entities
- product-local naming
- product-local workflows
- product runtime usage
- product canon boundaries

Product-local rules must not override engine root invariants.
Product-local rules are the product-level source of truth for domain invariants.

Toolkit products should encode shipping guidance in:

- `product.yaml`
- `README.md`
- the installed skills' `SKILL.md` files

Toolkit products should avoid a separate product-level `rules/` layer unless there is a strong engine-authoring reason to keep one.

## Local scoped rules

- a product may allow optional local scoped rules for one concrete workspace, entity, or other product-local working scope
- local scoped rules apply only to that specific scope and do not define product-wide behavior
- local scoped rules must live under the product rule layer, for example `products/<product_slug>/rules/workspace/<entity>/<slug>.md`
- local scoped rules may constrain local canon, local play boundaries, local tone, or other scope-specific invariants
- local scoped rules must not replace the primary content cards as the main readable source of truth
- local scoped rules must not override engine root invariants or product-wide rules
- skills working inside a product scope should read relevant local scoped rules when present

## All-workspace global rules

- a product may define one optional all-workspace rule file under `products/<product_slug>/rules/workspace/global.md`
- use all-workspace global rules when a constraint should apply to every workspace in that product regardless of workspace type
- all-workspace global rules are narrower than general product rules but broader than workspace-type global rules and workspace-local rules
- all-workspace global rules must not override engine root invariants or general product-wide rules
- skills working across different workspace types should read this layer when present

## Product-scoped rules under `rules/workspace/`

- a product may define optional scoped rule files under `products/<product_slug>/rules/workspace/`
- this directory is the product-local area for workspace and entity-specific working rules
- files in this directory may target every workspace, one workspace type, one concrete workspace, or one concrete entity scope such as a scenario, character, or quest
- scoped rule files are narrower than general product rules but broader than one concrete turn or runtime state
- scoped rule files must not override engine root invariants or general product-wide rules
- skills should read the matching scoped rule files when present
- exact filenames are product-specific because product ontology is product-specific

## Rule transfer between workspace scopes

- a product may support promoting a rule statement from one concrete scope or one broader scoped rule file into all-workspace global rules
- a product may support localizing an all-workspace global rule into one workspace type, one concrete workspace, or one concrete entity scope
- a product may support promoting a rule statement from one concrete entity or workspace into a broader scoped rule file under `rules/workspace/`
- a product may support localizing a broader scoped rule into one concrete scope
- products should document whether rule transfer belongs to an existing promotion workflow or to a dedicated rule-governance workflow
- when rule transfer is supported, the workflow must preserve meaning and resolve conflicts explicitly

## Workspace dictionaries

- if a product localizes workspace-facing card titles, section labels, or similar canon-facing UI text, it should keep those labels in a dedicated product-local dictionary area instead of hard-coding them across scripts and templates
- commit only template dictionary files to the repository by default
- local language realizations or user-adjusted wording should live in ignored non-template files
- shared labels that apply across multiple workspace card types should live in shared dictionary files such as `sections`
- labels that are unique to one entity or document type should live in a dictionary file for that entity or document type
- when the dictionary grows, keep splitting by source domain rather than returning to one monolithic catch-all file
- when card templates are added or refactored, update the relevant dictionary files in the same change so templates and dictionaries do not drift apart

## Mode ownership

- `dev` is the only engine-native mode
- all non-engine-native modes are product-local
- product-local modes must be defined by the product contract and product-local files
- product-local modes must not be defined in engine root
- toolkit products should omit product-local modes entirely

## Skill ownership

- engine-native skills belong in `.agents/skills/`
- embedded product-local skills belong in `products/<product_slug>/skills/`
- product-local workflows must not be promoted into engine root unless they are reusable engine capabilities
- toolkit product installable skills live in top-level skill folders directly under `products/<product_slug>/`
- toolkit product installable skills must be shaped so `skill-installer` can install them from a remote repository path without needing sibling shared folders

## Principle

The engine provides orchestration.  
Products provide domain behavior.
