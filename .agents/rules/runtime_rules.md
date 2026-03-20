# Runtime Rules

## Purpose

Runtime stores only engine-level context.

## Engine runtime role

- engine runtime is the active orchestration context for the current session
- engine runtime stores what is active now, not what each product last used
- engine runtime may mirror the currently active product mode as an operational snapshot
- engine runtime must stay product-agnostic except for product selection pointers

## Engine runtime semantics

- `mode` means the currently active mode for the current session
- `active_product_slug` means the currently selected product
- engine runtime is the source of truth only for current engine context
- engine runtime is not the source of truth for resumable product work context
- when the active mode is a product-local mode and the switch is persistent, engine runtime `mode` must mirror that active product-local mode

## One-shot override

- a one-shot override applies mode selection only to the current request
- a one-shot override has priority over stored runtime mode and persisted product mode
- a one-shot override must not write its temporary mode into engine runtime
- a one-shot override must not write its temporary mode into product runtime unless the user explicitly performs a persistent mode switch

## Allowed fields

- mode
- user_language
- engine_language
- content_language
- connected_product_slugs
- active_product_slug

## Product runtime boundary

- products may define their own runtime under `products/<product_slug>/state/runtime.yaml`
- product runtime stores resumable product-local context between sessions
- product runtime may store last-used mode and active product entity pointers
- on a persistent mode switch inside the active product, product runtime `last_mode` should be updated together with engine runtime `mode`
- workspace pointers and product-specific entity pointers belong only in product runtime
- product runtime must not be treated as engine runtime
- product runtime must not replace workspace content or workspace state

## Forbidden

- no product-specific entity ids
- no gameplay state
- no scene state
- no product workflow state
- no workspace state
- no turn counters
- no bootstrap flags

## Separation rule

- engine runtime stores active context
- product runtime stores resumable local context
- workspaces store product truth, content, and mutable domain state
- persistent mode switches should keep engine runtime and active product runtime mode pointers in sync

## Principle

Runtime is context, not state.
