# Layer Rules

## Layers

- engine → AGENTS, rules, runtime, engine-native skills
- product → product contract, product-local modes, product-local skills, product-local assets
- workspace → product-local mutable work container

## Workspace definition

- a workspace is a product-local container for one concrete unit of domain work
- a workspace stores instances, working content, and mutable product state
- a workspace is not an engine runtime context
- a workspace is not a product contract
- a workspace may represent:
    - a canonical entity workspace such as a world, character, chapter, or account
    - a stateful run workspace such as an adventure, session, draft run, or campaign instance

## Layer test

If something defines:

- global engine behavior
- engine-wide invariants
- active engine context

→ it does not belong in a workspace

If something defines:

- product identity
- product modes
- available workspace types
- product-local workflow surface

→ it belongs in the product layer, not in a workspace

If something defines:

- one concrete domain instance
- its working content
- its local history or progress
- its mutable state within a product

→ it belongs in a workspace

If something defines:

- the last local context for one product
- which product entities were open most recently
- which product mode should be resumed next time

→ it belongs in product runtime, not in engine runtime and not in a workspace

## Rules

- do not mix engine-native logic with product-local logic
- do not store product contracts in engine runtime
- do not store workspace state in engine or product contracts
- do not place product-local data in engine root
- do not treat a workspace as a generic folder with no domain identity

## Principle

Each layer has a single responsibility.
