# Product Rules

## Product model

- a product is a first-class engine extension unit
- each product lives under `products/<product_slug>/`
- each product owns its own rules, modes, skills, assets, runtime, and workspace

## Required product contract

Each product must define:

- `products/<product_slug>/product.yaml`
- `products/<product_slug>/AGENTS.md`
- `products/<product_slug>/rules/`

The product contract may define:

- product identity
- purpose and scope
- product-local mode namespace
- workspace contract

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
- if a product needs rules for one concrete workspace instance, keep them inside that workspace rather than elevating them into product-wide rules
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

## Runtime interplay

- use engine runtime for the product and mode that are active now
- use product runtime for the last known local context of that product
- if the active product is restored, engine runtime may be initialized from product runtime
- when a product is active, engine runtime and product runtime may temporarily point to the same mode, but they do not have the same responsibility

## Product-local rules

A product must define product-local rules under:
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

## Skill ownership

- engine-native skills belong in `.agents/skills/`
- product-local skills belong in `products/<product_slug>/skills/`
- product-local workflows must not be promoted into engine root unless they are reusable engine capabilities

## Principle

The engine provides orchestration.  
Products provide domain behavior.
