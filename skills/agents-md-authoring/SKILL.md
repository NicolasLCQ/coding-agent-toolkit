---
name: agents-md-authoring
description: Create or update AGENTS.md files with concise, evidence-based instructions scoped to their directory and inherited repository guidance.
---

# AGENTS.md Authoring

Create or update an `AGENTS.md` as durable guidance for coding agents. Its location determines its scope and therefore its content.

## Workflow

1. Identify the exact target directory. Ask when it is unspecified because choosing it changes which files inherit the guidance.
2. Inspect the effective instruction chain from global and repository-root guidance down to the target. Account for `AGENTS.override.md` and configured fallback filenames when present.
3. Inspect only the repository evidence needed to understand the target: manifests, build and CI configuration, contributor or architecture documentation, and representative tests.
4. Write instructions supported by that evidence and explicit user decisions. Do not infer commands, conventions, permissions, or business rules from the technology alone.
5. Validate the resulting file against its inherited guidance and the repository before finishing.

## Scope

- Global configuration: include only stable personal preferences and cross-repository defaults. Do not assume a language, package manager, command, or project structure.
- Repository root: include repository-wide purpose, boundaries, commands, conventions, and constraints. In a monorepo, leave package-specific details to nested files.
- Nested directory: include only the delta for that subtree, such as local commands, component boundaries, exceptions, and more specific rules. Do not repeat parent guidance that still applies.

Use the standard uppercase filename `AGENTS.md` unless the user explicitly requests a supported override or fallback filename.

## Content Rules

- Include only durable guidance that materially changes how an agent should work in this scope.
- Prefer actionable boundaries and exact commands, including their working directory, over generic coding advice.
- Link to authoritative documentation instead of copying it. State when it must be read rather than requiring every document for every task.
- Record project-specific architecture, testing, security, compatibility, deployment, review, or generated-code rules only when applicable.
- Avoid task plans, temporary status, broad repository inventories, tutorials, secrets, and configuration already enforced mechanically.
- Keep safety and approval boundaries narrow. Grant autonomy only for workflows known to be local, reversible, and isolated from production or external systems.
- Use concise Markdown with only the headings needed for the discovered content; `AGENTS.md` has no mandatory section schema.

## Updating a File

Preserve accurate institutional knowledge and explicit user decisions. Remove or consolidate guidance only when repository evidence establishes that it is obsolete, duplicated, misplaced, or unsupported.

Do not edit parent or nested instruction files unless they are in scope. Ask for the expected rule when authoritative sources conflict or when a change could alter product, security, release, or team behavior.

## Validation

Confirm that referenced paths and commands exist, nested rules are more specific than inherited rules, the effective instruction chain has no unintended contradiction or repetition, and the diff contains no unrelated changes.

Report the target scope, the evidence used, the material guidance changed, and any remaining uncertainty.
