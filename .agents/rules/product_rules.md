# Product Rules

## Product model

- a product is a first-class engine extension unit
- each product lives under `products/<product_slug>/`
- each product owns its own rules, modes, skills, assets, runtime, and workspaces

## Required product contract

Each product must define:

- `products/<product_slug>/product.yaml`
- `products/<product_slug>/AGENTS.md`
- `products/<product_slug>/rules/`

The product contract may define:

- product identity
- purpose and scope
- product-local mode namespace
- workspace model

## Workspace model

- `workspace_model` defines which workspace unit types the product supports
- `workspace_model` does not store workspace instances or workspace state
- workspace instances live under the product workspace root
- each workspace unit should represent one concrete domain work container
- workspace units may be:
    - canonical entity workspaces such as worlds, characters, books, or contacts
    - stateful run workspaces such as adventures, sessions, draft runs, or deal cycles

## Workspace boundary

- use `product.yaml` to define the available workspace ontology
- use `products/<product_slug>/workspaces/` to store concrete workspace instances
- do not store active workspace progress in `product.yaml`
- do not use engine runtime as a substitute for product workspaces
- if a product needs rules for one concrete workspace instance, keep them inside that workspace rather than elevating them into product-wide rules

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
- product workspaces
- product-local naming
- product-local workflows
- product runtime usage
- product canon boundaries

Product-local rules must not override engine root invariants.
Product-local rules are the product-level source of truth for domain invariants.

## Workspace-local rules

- a product may allow optional workspace-local rules inside one concrete workspace instance
- workspace-local rules apply only to that specific workspace and do not define product-wide behavior
- workspace-local rules must live under that workspace root, for example `products/<product_slug>/workspaces/<type>/<slug>/rules/`
- workspace-local rules may constrain local canon, local play boundaries, local tone, or other workspace-specific invariants
- workspace-local rules must not replace the primary workspace cards as the main readable source of truth
- workspace-local rules must not override engine root invariants or product-wide rules
- skills working inside a workspace should read relevant workspace-local rules when present

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
