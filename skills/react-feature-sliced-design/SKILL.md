---
name: react-feature-sliced-design
description: Design, implement, migrate, refactor, or review React JavaScript/TypeScript applications that use Feature-Sliced Design (FSD), including layer direction, slice isolation, segments, and public APIs.
---

# React Feature-Sliced Design

Apply this skill when a React change affects FSD placement, layer boundaries, slice ownership, public APIs, imports, application composition, or an incremental migration to FSD.

## Workflow

1. Inspect the repository structure, framework conventions, path aliases, public exports, and affected imports before proposing a placement.
2. Read [references/architecture.md](references/architecture.md) for every architecture, implementation, refactoring, or review task.
3. Also read [references/react-conventions.md](references/react-conventions.md) when creating or reviewing React components, hooks, state, API access, routing, or tests.
4. For an existing non-FSD codebase or a broad restructuring, read [references/migration.md](references/migration.md) and migrate incrementally.
5. Place code in the layer whose semantic responsibility and reuse scope match the change, without creating an upward dependency. Use only the layers that add value to the project.
6. Verify layer direction, same-layer slice isolation, public API usage, and the absence of circular dependencies.
7. Run the repository's relevant type checks, lint checks, architecture checks, and tests after changing code.

## Essential Constraints

- Use the standard layers in descending order: `app`, `pages`, `widgets`, `features`, `entities`, `shared`.
- A module may import only from its own slice and from layers strictly below it. Different slices on the same layer are isolated.
- `app` and `shared` contain segments directly; the other layers contain business-oriented slices, then purpose-oriented segments.
- Expose each slice through an explicit public API. Import another slice through that API, never through its internal files.
- Use relative full-path imports inside a slice; do not import a slice's own public API from within that slice.
- Keep cross-imports between same-layer slices out of the design. Treat entity `@x` APIs as a documented last resort for unavoidable entity relationships.
- Name slices by product or business meaning and segments by purpose. Avoid generic dumping grounds such as `components`, `hooks`, `types`, or `utils` as segments.
- Keep `shared` free of application-specific business rules. Do not move code there merely because it is reused twice.
- Preserve framework-required entrypoints and routing conventions; use thin adapters when a framework-owned directory cannot follow the FSD tree.
- Do not introduce circular dependencies.
