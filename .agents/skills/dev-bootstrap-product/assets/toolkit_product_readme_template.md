# {{product_name}}

Portable Codex toolkit repository for {{product_purpose}}.

## Purpose

- intended to be installed through `skill-installer`
- may contain multiple installable self-contained skills in one repository
- should remain usable without copying the whole `product-engine` repository

## Installation

- install one or more skills from this repository with `skill-installer`
- restart Codex after installation so the new skills are discovered
- use `tmp/{{product_slug}}/` in the host project for temporary reports and transient machine artifacts

## Main Parts

- manifest
- installable skill folders at the product root

## Principle

Each shipped skill should stand on its own.  
The repository groups related installable capabilities.
