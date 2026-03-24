# Product Structure Checklist

Before creating a new product, check:

- Is this a separate product and not just a new engine-native skill?
- Is this an embedded product or a portable toolkit product?
- Does the product have a clear purpose and scope?
- Will the product define its own modes?
- Does the product need a dedicated `workspace/` root?
- For a toolkit product, should it be installable through `skill-installer` as one or more self-contained skills?
- Does the product define an initial `rules/` layer, or should the toolkit rely only on `product.yaml`, `README.md`, and per-skill `SKILL.md` files?
- Does the product need `rules/workspace/` as a local rule area for workspace or entity-specific working rules?
- Does the product need product-local resumable runtime?
- Should the product avoid `state/`, `modes/`, and `workspace/` entirely?
- Should the product write all temporary artifacts and reports into host-project `tmp/<product_slug>/`?
- Should each toolkit skill folder remain fully self-contained without shared top-level support folders?
- Is `product.yaml` enough for the first scaffold?
- Should `.gitignore` exclude mutable product runtime?
- Should `.gitignore` preserve `rules/workspace/.gitkeep` while ignoring other local rule files there?
- Can the initial structure stay minimal?
