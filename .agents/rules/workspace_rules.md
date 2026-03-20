# Workspace Rules

## Purpose

Define the shared engine contract for product-wide all-workspace rules, product-specific scoped rule files, concrete local rule files, and rule transfer between those layers.

## Rule layers

- engine rules define engine-wide invariants
- product rules define product-wide domain invariants
- all-workspace global rules define optional defaults for every workspace inside one product
- scoped product rule files define optional defaults or constraints for one named product scope under `rules/workspace/`
- local rule files define invariants for one concrete product scope or entity instance

## Product-wide all-workspace rules

- a product may define one optional all-workspace rule file under `products/<product_slug>/rules/workspace/`
- preferred path:
  - `products/<product_slug>/rules/workspace/global.md`
- use this layer when a constraint should apply to every workspace in that product regardless of workspace type
- if this file is absent, that product simply has no all-workspace-specific defaults beyond its ordinary product rules

## Product-scoped rule files

- a product may define optional scoped rule files under `products/<product_slug>/rules/workspace/`
- these files may target:
  - one workspace type across the whole product
  - one concrete workspace instance
  - one product entity type or one concrete entity instance such as a scenario, character, quest, or similar product-local scope
- preferred path shapes:
  - `products/<product_slug>/rules/workspace/<entity>.md`
  - `products/<product_slug>/rules/workspace/<entity>/<slug>.md`
- exact filenames are product-specific because product ontology is product-specific
- if a matching scoped rule file is absent, that scope simply has no extra defaults at that layer

## Local scoped rule files

- a product may define optional local scoped rule files for one concrete entity instance, or other product-local scope
- preferred path shape:
  - `products/<product_slug>/rules/workspace/<entity>/<slug>.md`
- local scoped rules apply only to that one concrete scope

## Reading order

- apply engine rules first
- then apply product-wide rules
- then apply all-workspace global rules when present
- then apply any relevant scoped rule files under `rules/workspace/`
- then apply any relevant local scoped rule files for the concrete workspace entity, or working scope
- if a narrower rule conflicts with a broader rule, prefer the broader invariant and surface the conflict explicitly

## Rule transfer

- products may support transferring rule statements between:
  - all-workspace global rules and scoped rule files
  - all-workspace global rules and local scoped rule files
  - local scoped rule files and broader scoped rule files
  - broader and narrower scopes of the same product rule domain
- when a local or type-specific rule is generalized into the all-workspace global rule, treat that as rule promotion
- when a local rule is generalized into a broader scoped rule file, treat that as rule promotion
- when an all-workspace global rule is narrowed into one workspace type, one concrete workspace, or one concrete entity scope, treat that as rule localization
- when a broader scoped rule file is brought down into one narrower concrete scope, treat that as rule localization

## Transfer semantics

- rule promotion should preserve meaning while removing accidental workspace-specific phrasing
- rule localization should preserve the broader intent while narrowing it for one concrete workspace
- rule promotion should remove the source-local duplicate by default only when the promoted global rule fully supersedes it for that workspace
- rule localization should keep the original broader rule by default unless the user explicitly wants to narrow product-wide behavior
- if the transfer changes actual canon-bearing content expectations, update the affected cards or related instructions explicitly

## Skill guidance

- if a product already has a promotion workflow, prefer extending that workflow to support rule transfer
- create a dedicated rule-transfer skill only when rule governance becomes a distinct workflow with materially different steps, reviews, or batching needs

## Constraints

- do not treat workspace rules as runtime
- do not let all-workspace global rules replace ordinary product-wide rules
- do not let scoped rule files replace product-wide rules
- do not let local scoped rule files masquerade as product-wide defaults
- do not silently broaden one workspace rule into a product-wide invariant

## Principle

Broader rules define defaults.  
Narrower rules define justified exceptions or local constraints.
