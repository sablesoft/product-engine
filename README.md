# Product Engine

`product-engine` is a mode-driven engine for building products on top of a shared development runtime.

It separates:

- engine behavior
- product contracts
- product-local rules and runtimes
- workspace content and product state

## What lives here

- engine instructions and policies in [AGENTS.md](/Users/roman/PhpstormProjects/home/product-engine/AGENTS.md)
- engine rules in [.agents/rules](/Users/roman/PhpstormProjects/home/product-engine/.agents/rules)
- engine-native skills in [.agents/skills](/Users/roman/PhpstormProjects/home/product-engine/.agents/skills)
- engine runtime in [state/runtime.yaml](/Users/roman/PhpstormProjects/home/product-engine/state/runtime.yaml)
- products in [products](/Users/roman/PhpstormProjects/home/product-engine/products)

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

Products live under [products](/Users/roman/PhpstormProjects/home/product-engine/products).

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

## First places to read

- [AGENTS.md](/Users/roman/PhpstormProjects/home/product-engine/AGENTS.md)
- [.agents/rules/runtime_rules.md](/Users/roman/PhpstormProjects/home/product-engine/.agents/rules/runtime_rules.md)
- [.agents/rules/product_rules.md](/Users/roman/PhpstormProjects/home/product-engine/.agents/rules/product_rules.md)
- [.agents/rules/layer_rules.md](/Users/roman/PhpstormProjects/home/product-engine/.agents/rules/layer_rules.md)
- [.agents/skills/dev-bootstrap-product/SKILL.md](/Users/roman/PhpstormProjects/home/product-engine/.agents/skills/dev-bootstrap-product/SKILL.md)

## Status

The engine is under active design and refactoring.
The architecture is centered on explicit layers, reusable product scaffolding, and independent content repositories.
