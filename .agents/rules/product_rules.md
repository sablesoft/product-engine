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
