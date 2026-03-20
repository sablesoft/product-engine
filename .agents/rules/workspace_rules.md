# Workspace Rules

## Purpose

Define the shared engine contract for product-wide all-workspace rules, product-specific workspace-type rules, concrete workspace-local rules, and rule transfer between those layers.

## Rule layers

- engine rules define engine-wide invariants
- product rules define product-wide domain invariants
- all-workspace global rules define optional defaults for every workspace inside one product
- workspace-type global rules define invariants for every workspace instance of one workspace type inside a product
- workspace-local rules define invariants for one concrete workspace instance

## Product-wide all-workspace rules

- a product may define one optional all-workspace rule file under `products/<product_slug>/rules/workspaces/`
- preferred path:
  - `products/<product_slug>/rules/workspaces/global.md`
- use this layer when a constraint should apply to every workspace in that product regardless of workspace type
- if this file is absent, that product simply has no all-workspace-specific defaults beyond its ordinary product rules

## Product-specific workspace-type rules

- a product may define optional workspace-type global rule files under `products/<product_slug>/rules/workspaces/`
- each such file should constrain one workspace type across the whole product
- preferred path shape:
  - `products/<product_slug>/rules/workspaces/<workspace_type>.md`
- use workspace-type global rules when the constraint should apply to every workspace of that type, not just one instance
- workspace-type filenames are product-specific because workspace ontology is product-specific
- if a matching workspace-type rule file is absent, that workspace type simply has no extra defaults at that layer

## Workspace-local rules

- a product may define optional workspace-local rules inside one concrete workspace instance
- preferred path shape:
  - `products/<product_slug>/workspaces/<workspace_type>/<workspace_slug>/rules/`
- workspace-local rules apply only to that one workspace

## Reading order

- apply engine rules first
- then apply product-wide rules
- then apply all-workspace global rules when present
- then apply workspace-type global rules for the relevant workspace type when present
- then apply workspace-local rules for the concrete workspace when present
- if a narrower rule conflicts with a broader rule, prefer the broader invariant and surface the conflict explicitly

## Rule transfer

- products may support transferring rule statements between:
  - all-workspace global rules and workspace-type global rules
  - all-workspace global rules and workspace-local rules
  - workspace-local rules and workspace-type global rules
  - broader and narrower scopes of the same product rule domain
- when a local or type-specific rule is generalized into the all-workspace global rule, treat that as rule promotion
- when a local rule is generalized into a workspace-type global rule, treat that as rule promotion
- when an all-workspace global rule is narrowed into one workspace type or one concrete workspace, treat that as rule localization
- when a workspace-type global rule is brought down into one concrete workspace, treat that as rule localization

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
- do not let workspace-type global rules replace product-wide rules
- do not let workspace-local rules masquerade as product-wide defaults
- do not silently broaden one workspace rule into a product-wide invariant

## Principle

Broader rules define defaults.  
Narrower rules define justified exceptions or local constraints.
