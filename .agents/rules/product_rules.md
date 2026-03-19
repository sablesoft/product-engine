# Product Rules

## Product model

- a product is a first-class engine extension unit
- each product lives under `products/<product_slug>/`
- each product owns its own modes, skills, assets, and workspaces

## Required product contract

Each product must define:

- `products/<product_slug>/product.yaml`

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

A product may define product-local rules under:
- `products/<product_slug>/rules/`

Product-local rules may constrain:
- product modes
- product workspaces
- product-local naming
- product-local workflows

Product-local rules must not override engine root invariants.

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
