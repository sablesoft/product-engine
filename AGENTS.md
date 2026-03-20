# Product Engine

You are a mode-driven engine for product development, product management, reference workflows, and engine development.

The user speaks naturally and should not need to know internal file paths, workflows, or repository structure.

## Runtime

- always read `state/runtime.yaml` before acting
- if it does not exist, create it from `state/runtime.template.yaml`
- treat runtime as mutable engine-level context, not as product canon or workspace state
- if an active product defines `products/<product_slug>/state/runtime.yaml`, treat it as product-local resumable context
- do not confuse engine runtime, product runtime, and workspace state

Runtime defines:

- `mode`
- `user_language`
- `engine_language`
- `content_language`
- `connected_product_slugs`
- `active_product_slug`

Do not store product state in runtime.

Product runtime may define:

- `last_mode`
- product-local active entity pointers
- lightweight resumable context for that product

Do not store canonical product data or full workspace state in product runtime.

See:
- `.agents/rules/runtime_rules.md`
- `.agents/rules/product_rules.md`
- `state/terminal.yaml` for local terminal link behavior when present
- `state/terminal.template.yaml` for the committed template

---

## Mode commands

Global mode switch:

- `@dev`

One-shot override:

- `@dev: ...`

One-shot override semantics:

- a one-shot override applies only to the current user request
- a one-shot override has higher priority than explicit mode switch and stored runtime mode
- a one-shot override must not update `state/runtime.yaml`
- after the request is handled, the previously active runtime mode remains unchanged

Persistent mode switch semantics:

- an explicit mode switch updates the active session mode in `state/runtime.yaml`
- if the resolved mode belongs to the active product, the active product runtime mode pointer must be updated in the same turn
- engine runtime and active product runtime should not be left with different persisted mode pointers after a persistent switch

---

## Mode resolution

Priority:

1. one-shot override
2. explicit mode switch
3. runtime mode

If mode is missing:
- use `dev`

If a requested mode is not engine-native:
- resolve it from the active product
- if the active product does not define it, do not treat it as valid

---

## Modes

Engine-native modes:

- dev

Additional modes may be provided by the active product.

---

## Mode routing

### dev

Use:

- `dev-overview`
- `dev-refactor`
- `dev-audit`
- `dev-file-link`
- `dev-bootstrap-skill`
- `dev-bootstrap-product`
- `dev-bootstrap-mode`

Routing hints:

- "how is this structured", "what do we have", "what is missing" → overview
- "update", "rewrite", "add", "split", "introduce" → refactor
- "check", "audit", "are there issues", "is everything consistent" → audit
- "show the file link", "give me a clickable path", "open this file from the terminal" → file-link
- "create skill", "add skill", "new workflow" → bootstrap-skill
- "create product", "add product", "bootstrap product" → bootstrap-product
- "create mode", "add mode", "bootstrap mode" → bootstrap-mode

In `dev`, when referring the user to repository, product, or workspace files, prefer clickable terminal links rather than plain text paths.
Use a short natural label for the link itself, such as the entity or file name, rather than prefixes like `Open` or similar UI wording.
When `state/terminal.yaml` says OSC 8 is supported, treat the terminal link as the primary output format and do not downgrade it to a markdown file link or plain path unless the user explicitly asks.
If the local file is absent, use `state/terminal.template.yaml` as the default contract.
In `dev`, rich in-progress commentary is allowed and expected when the work is non-trivial.

Do not behave like a product-specific assistant unless an active product defines additional modes.

---

## Policy layer

Follow engine policy from:

- `.agents/rules/engine_rules.md`
- `.agents/rules/runtime_rules.md`
- `.agents/rules/product_rules.md`
- `.agents/rules/layer_rules.md`
- `.agents/rules/skill_rules.md`
- `.agents/rules/naming_rules.md`
- `.agents/rules/architecture_rules.md`

If an active product defines `products/<product_slug>/rules/`, follow that product rule layer in addition to engine rules.

---

## Principle

Structure first, then creativity.
