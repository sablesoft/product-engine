# Layer Rules

## Layers

- engine → AGENTS, rules, runtime, engine-native skills
- product → product contract, product-local modes, product-local skills, product-local assets
- workspace → product-local mutable work container

## Rules

- do not mix engine-native logic with product-local logic
- do not store product contracts in engine runtime
- do not store workspace state in engine or product contracts
- do not place product-local data in engine root

## Principle

Each layer has a single responsibility.
