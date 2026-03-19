# Product Engine

`product-engine` is a mode-driven engine for building products on top of a shared development runtime.

It separates:

- engine behavior
- product contracts
- product-local rules and runtimes
- workspace content and product state

## What lives here

- engine instructions and policies in [AGENTS.md](AGENTS.md)
- engine rules in [.agents/rules](.agents/rules)
- engine-native skills in [.agents/skills](.agents/skills)
- engine runtime in [state/runtime.yaml](state/runtime.yaml)
- products in [products](products)

## Layer model

- `engine` defines global behavior, routing, shared rules, and bootstrap workflows
- `product` defines a domain package with its own modes, rules, skills, runtime, and workspace model
- `workspace` stores concrete domain content and mutable state

The engine should stay independent from product content.
Products should stay independent from concrete workspace content.

## Runtime model

There are three different runtime layers:

- engine runtime: current global context such as active product and current mode
- product runtime: resumable local context for one product
- workspace state: actual product data and mutable run state

Do not mix them.

## Products

Products live under [products](products).

Each product may define:

- its own `product.yaml`
- product-local `AGENTS.md`
- product-local `rules/`
- product-local `modes/`
- product-local `skills/`
- product-local `state/runtime.yaml`
- product-local `workspaces/`

## Repository strategy

This repository stores the engine and product scaffolding.

Concrete content may live in nested repositories:

- each product may have its own git repository
- each world workspace may have its own git repository
- each adventure workspace may have its own git repository

This keeps engine evolution separate from real content.

## Temporary Files

Use the project-local `tmp/` directory for temporary artifacts created during work in this repository.
Prefer it over system temp directories when the output may need to be inspected from the repo root.

## First places to read

- [AGENTS.md](AGENTS.md)
- [.agents/rules/runtime_rules.md](.agents/rules/runtime_rules.md)
- [.agents/rules/product_rules.md](.agents/rules/product_rules.md)
- [.agents/rules/layer_rules.md](.agents/rules/layer_rules.md)
- [.agents/skills/dev-bootstrap-product/SKILL.md](.agents/skills/dev-bootstrap-product/SKILL.md)

## Status

The engine is under active design and refactoring.
The architecture is centered on explicit layers, reusable product scaffolding, and independent content repositories.
