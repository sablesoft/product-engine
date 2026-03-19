# {{product_name}} Rules

## Purpose

Define product-level invariants, domain boundaries, and workflow constraints for `{{product_slug}}`.

## Rules

- narrow engine rules to this product domain
- define canon and state boundaries for this product
- define product runtime boundaries for this product
- define mode-specific constraints when they are product-wide

## Constraints

- do not override engine root invariants
- do not duplicate workspace content into rules
- do not duplicate product contract fields into rules unless needed for a boundary

## Principle

Product rules govern domain behavior.  
Workspaces store product truth.
