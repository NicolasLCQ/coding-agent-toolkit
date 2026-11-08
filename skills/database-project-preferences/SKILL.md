---
name: database-project-preferences
description: Apply database project preferences when creating, changing, or reviewing database-backed solutions, using database-first development followed by scaffolding persistence code into the solution.
---

# Database Project Preferences

- Use database-first development: the database schema is the source of truth for persistence structure.
- Define or update the database schema before generating the corresponding persistence code. Do not use code-first ORM migrations to drive schema changes.
- Scaffold persistence models, mappings, and context or client artifacts from the database into the solution using the selected technology's reverse-engineering tools and the solution's existing project boundaries.
- Rerun scaffolding after schema changes. Keep handwritten customizations outside generated files so regeneration preserves them.
