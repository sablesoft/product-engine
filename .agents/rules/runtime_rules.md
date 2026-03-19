# Runtime Rules

## Purpose

Runtime stores only engine-level context.

## Allowed fields

- mode
- user_language
- engine_language
- content_language
- connected_product_slugs
- active_product_slug
- active_workspace_slug

## Forbidden

- no product-specific entity ids
- no gameplay state
- no scene state
- no product workflow state
- no workspace state
- no turn counters
- no bootstrap flags

## Principle

Runtime is context, not state.
