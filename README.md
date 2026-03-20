# Product Engine

`product-engine` is a mode-driven engine for building products on top of a shared development runtime.

It separates:

- engine behavior
- product contracts
- product-local rules and runtimes
- all-workspace global rules
- workspace-type global rules
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

Products may optionally define three workspace rule layers:

- all-workspace global rules for every workspace entity in the product, for example `products/<product_slug>/rules/workspace/global.md`
- product-scoped rule files for workspace entity, for example `products/<product_slug>/rules/workspace/<entity>.md`
- local scoped rule files for one concrete workspace entity instance, for example `products/<product_slug>/rules/workspace/<entity>/<slug>.md`

This makes it possible to keep shared workspace defaults and local working rules out of individual content folders while still allowing justified local constraints for any product scope.

## Runtime model

There are three different runtime layers:

- engine runtime: current global context such as active product and current mode
- product runtime: resumable local context for one product
- workspace state: actual product data and mutable run state

Do not mix them.

For persistent mode switches, keep the active engine mode and the active product's persisted mode pointer synchronized when the chosen mode is product-local. One-shot overrides remain temporary and must not rewrite either runtime.

## Products

Products live under [products](products).

Each product may define:

- its own `product.yaml`
- product-local `AGENTS.md`
- product-local `rules/`
- product-local `rules/workspace/`
- product-local `modes/`
- product-local `skills/`
- product-local `state/runtime.yaml`
- product-local `workspace/`

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

## Terminal Links

The engine provides shared terminal-link helpers that any product can use.

- generic file links:
  - [scripts/file-link](scripts/file-link)
  - [scripts/support/terminal_file_link.rb](scripts/support/terminal_file_link.rb)
- image-specific links with Kitty-aware handling:
  - [scripts/image-link](scripts/image-link)
  - [scripts/support/terminal_image_link.rb](scripts/support/terminal_image_link.rb)

Use them like this:

```bash
ruby scripts/file-link --path path/to/file.md
ruby scripts/image-link --path path/to/image.png
```

Behavior:

- both scripts emit clickable OSC 8 `file://` links
- on macOS they also print a ready `open ...` fallback command
- `image-link` is the image-specific subset of `file-link`
- in Kitty, `image-link` also maintains compatible `open_actions` so image clicks can open with `kitten icat`

## First places to read

- [AGENTS.md](AGENTS.md)
- [.agents/rules/runtime_rules.md](.agents/rules/runtime_rules.md)
- [.agents/rules/product_rules.md](.agents/rules/product_rules.md)
- [.agents/rules/workspace_rules.md](.agents/rules/workspace_rules.md)
- [.agents/rules/layer_rules.md](.agents/rules/layer_rules.md)
- [.agents/skills/dev-bootstrap-product/SKILL.md](.agents/skills/dev-bootstrap-product/SKILL.md)

## Status

The engine is under active design and refactoring.
The architecture is centered on explicit layers, reusable product scaffolding, and independent content repositories.
