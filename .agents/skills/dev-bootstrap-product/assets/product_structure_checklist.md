# Product Structure Checklist

Before creating a new product, check:

- Is this a separate product and not just a new engine-native skill?
- Does the product have a clear purpose and scope?
- Will the product define its own modes?
- Does the product need a dedicated `workspace/` root?
- Does the product need a product-local `AGENTS.md` entrypoint?
- Does the product define an initial `rules/` layer?
- Does the product need `rules/workspace/` as a local rule area for workspace or entity-specific working rules?
- Does the product need product-local resumable runtime?
- Is `product.yaml` enough for the first scaffold?
- Should `.gitignore` exclude mutable product runtime?
- Should `.gitignore` preserve `rules/workspace/.gitkeep` while ignoring other local rule files there?
- Can the initial structure stay minimal?
