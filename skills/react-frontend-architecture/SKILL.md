---
name: react-frontend-architecture
description: Design, implement, refactor, or review React JavaScript/TypeScript applications that use the prescribed app, api, config, pages, shared, and widgets architecture and its import boundaries.
---

# React Front-End Architecture

Apply this skill when a React change affects project structure, module ownership, external communication, data-fetching placement, providers, reusable UI, naming, or imports.

## Workflow

1. Inspect the repository structure, aliases, public exports, and affected imports before placing or moving code.
2. Read [references/architecture.md](references/architecture.md) for every architecture, implementation, refactoring, or review task.
3. Also read [references/implementation-conventions.md](references/implementation-conventions.md) when creating or reviewing components, hooks, providers, styles, clients, services, API routes, or names.
4. Assign each responsibility to exactly one of the six prescribed top-level directories. Keep external communication inside `api` and runtime configuration inside `config`.
5. Enforce the dependency matrix, public entry points, data-fetching boundaries, and circular-dependency prohibition.
6. Verify affected imports and confirm that presentational child components receive external data through props.

## Essential Constraints

- `api` is the only layer that communicates with external systems.
- React code consumes external services through `api/hooks`; it does not call `api/clients` or `api/services` directly.
- Only application providers, route-level pages, and root widgets may call `api/hooks`.
- `shared` stays generic and wraps external components or design-system components before application code uses them.
- Cross-folder imports use the public `index.ts` entry points at the depths defined in the architecture reference.
- Provider-context hooks are owned by their provider file under `app/providers` and may be consumed by pages and widgets. Treat these imports as the architecture's narrow exception to the otherwise downward dependency direction; do not generalize the exception to other `app` modules.
- Do not introduce circular dependencies.

# TODO :: modify archi ? api in shared ? feature ? feat with existing architecture a little more ? find best match ? define how to code ? search for clean archi implementation of react front end ?