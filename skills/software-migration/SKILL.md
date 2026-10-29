---
name: software-migration
description: Plan, implement, or review software migrations across architectures, frameworks, libraries, runtimes, tooling, APIs, or data boundaries while preserving behavior and controlling migration risk.
---

# Software Migration

Apply these principles to any software migration. Combine them with the target technology's specific migration procedure and repository conventions.

## Principles

- Migrate incrementally; do not require a big-bang rewrite.
- Preserve behavior and keep the application runnable between steps.
- Move code according to current ownership, not an imagined future taxonomy.
- Accept temporary, documented violations when removing them in the same change would make the migration unsafe or excessively broad.
- Avoid adding large new abstractions while responsibilities are still being discovered.
- Use the repository's existing test, lint, and type-check feedback throughout the migration.
