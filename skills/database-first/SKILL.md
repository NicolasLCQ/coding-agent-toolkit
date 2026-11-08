---
name: database-first
description: Apply database-first development and schema scaffolding when creating, changing, or reviewing database-backed persistence models and data access. Use the database schema as the source of truth and regenerate database mappings with the selected technology's reverse-engineering tools.
---

# Database First

## Source of truth

- Use database-first development for projects with a database. Define persistence structure in the database schema, then scaffold the corresponding persistence models and mappings from that schema.
- Do not use application models or code-first ORM migrations to define or update the database schema. Version schema changes using the project's SQL scripts, database project, or database-owned migration tooling.
- Inspect the database engine, data-access technology, schema sources, existing generation commands, and generated-file boundaries before making changes. Do not silently convert an existing code-first project; report the conflict and clarify the transition scope.
- Keep business and API models independent from generated persistence models, following the project's architectural boundaries.

## Schema changes

- For an existing database, inspect the relevant schema before designing persistence code. For a new database, define the schema first from the specified requirements.
- Preserve existing data and contracts. Clarify missing decisions about nullability, keys, relationships, defaults, or data conversion when the requirements and existing schema do not establish them.
- Prepare schema changes as versioned artifacts. Apply them only to an authorized target; scaffolding does not authorize changes to a shared or production database.
- When a live target cannot be used, use an isolated database built from the authoritative schema artifacts if the tooling supports it. Report a blocker if no authoritative schema or suitable generation tool is available rather than inventing a schema or hand-writing a substitute scaffold.

## Scaffold and regenerate

- Use the selected technology's maintained schema introspection or reverse-engineering tooling. Consult its official documentation for commands and options compatible with the project's versions; reuse the repository's existing generation workflow when suitable.
- Generate persistence models, mappings, and context or client artifacts supported by that tool. Keep queries and other handwritten data-access behavior outside generated files.
- Restrict generation to the relevant schemas and objects while retaining dependencies required for correct mappings. Preserve established namespaces, paths, names, and generation options across runs.
- Keep connection credentials out of committed files, generated code, command history, and logs. Use the tooling's supported configuration or secret mechanism and disable embedded connection strings when supported. Use an account with only the permissions needed to inspect the schema.
- Treat generated files as reproducible output. Put custom behavior in supported extension points, partial classes, separate configuration, or wrappers so regeneration preserves it.
- Before overwriting existing files, inspect their changes and separate handwritten customizations. Generate into a temporary directory for comparison when overwrite behavior is uncertain; do not use force options to discard custom work.
- After a schema change, rerun scaffolding and review the complete diff, including removed or renamed objects and stale generated artifacts. Do not hand-edit generated models to simulate a schema change.
- Keep the generation command and its non-secret options reproducible through the repository's existing script or documentation conventions.

## Verification

- Check that generated mappings reflect the schema's types, nullability, keys, relationships, defaults, and computed or generated values. Identify unsupported objects or mappings explicitly rather than silently approximating them.
- Build or type-check the affected code and run relevant data-access checks against an isolated test database. Check schema or data-conversion scripts when changed; do not use production data for tests.
- Report the authoritative schema used, schema artifacts changed, scaffold command with secrets omitted, generated-code changes, and verification results or blockers.
