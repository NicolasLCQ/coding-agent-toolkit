# React Conventions for FSD

Read this reference when creating or reviewing React components, hooks, state, API access, routing, or tests. Placement and dependency rules remain defined in [architecture.md](architecture.md).

## Inspect Before Placing Code

Before adding a module, identify:

- the user or business responsibility it serves;
- whether it is route-local, a reusable page section, a product interaction, a domain concept, or generic infrastructure;
- who needs to import it;
- whether the repository already has an owning slice;
- which framework files, aliases, state tools, data-fetching tools, and styling conventions already exist.

Preserve established code conventions when they do not violate FSD boundaries. FSD defines ownership and dependencies, not a mandatory React library stack.

## Placement Heuristics

Use this order when deciding ownership:

1. Keep code in the current slice when it has one owner.
2. Put route-specific composition and behavior in the relevant `pages` slice.
3. Extract a substantial independently meaningful page block to `widgets`.
4. Extract a user-valued interaction to `features` when it has a clear reuse or ownership boundary.
5. Put stable domain representation and domain rules in `entities`.
6. Put business-agnostic primitives and integrations in `shared`.
7. Put only application-wide setup and composition in `app`.

Do not promote code solely because two files use it. Consider whether the consumers share one responsibility or merely look similar today.

## Components and Hooks

- Keep components, styles, tests, and stories close to their owner.
- A component may compose modules from lower layers, but lower-layer components must not import a higher-layer component or hook.
- Expose composition points through props, children, render props, callbacks, or context owned at an allowed layer.
- Place hooks by responsibility, not in a global hooks folder: request hooks in the owning `api`, state and business hooks in `model`, UI-only hooks in `ui`, and generic focused hooks in an appropriate `shared/lib` module.
- Avoid components that combine unrelated fetching, domain decisions, and presentation. Split them along existing slice or segment boundaries when doing so creates a clearer owner.
- Keep error, empty, and loading states near the use case that understands them. Do not force product-specific states into the generic UI kit.

## State and Business Logic

- Keep local UI state in the component when no broader owner needs it.
- Put slice-wide state, validation, selectors, and business rules in that slice's `model` segment.
- Put application store creation and provider wiring in `app`; keep domain stores and reducers in their owning slices.
- Do not centralize all stores, reducers, contexts, actions, or types by technical kind.
- Prefer explicit inputs and public contracts over importing another slice's internal state.

## API and External Systems

- Put generic transport setup, request primitives, interceptors, and external SDK wrappers in `shared/api` or another focused `shared` segment.
- Put endpoint operations, DTOs, mappers, and query definitions with the slice that owns the use case or data.
- Keep page-specific loaders or server actions in the page's `api` segment when they exist only for that route.
- Do not require all API calls to pass through one global featureless service layer.
- Keep server-only and client-only code behind separate entrypoints when the framework or bundler requires it.
- Pass authorization or session dependencies in a way that preserves layer direction. Wire global providers or injected dependencies in `app`.

## Routing and Framework Boundaries

Framework routing may reserve directories such as `app`, `pages`, or `routes`. Do not rename or relocate required files merely to match the reference tree.

When the framework owns a route file:

- keep it thin;
- import a page slice through its public API;
- re-export route handlers or metadata where supported;
- place route-specific implementation in the page slice when the framework permits it.

For frameworks with server and client module graphs, validate both the FSD dependency direction and the runtime boundary. An architecturally valid import can still be invalid if it pulls server code into a client bundle.

## Imports

Use absolute aliases for imports across slices:

```ts
import { ProductCard } from "@/entities/product";
import { Button } from "@/shared/ui/button";
```

Use explicit relative imports inside one slice:

```ts
import { mapProductDto } from "../lib/mapProductDto";
```

Avoid:

```ts
import { ProductCard } from "@/entities/product/ui/ProductCard"; // private deep import
import { useCart } from "@/features/cart"; // from another feature slice
import { mapProductDto } from ".."; // own public API; cycle risk
```

Keep aliases aligned with the real layer roots. Do not use aliases to disguise an invalid dependency.

## Styling and Assets

- Colocate component-specific styles and assets with the owning UI module.
- Keep design tokens, resets, and generic UI primitives in `shared` when reusable.
- Keep application-wide global style wiring in `app`.
- Product-specific visuals belong to the slice that owns their meaning, even when the underlying image or icon loader is shared.

## Tests

- Place unit and component tests near the module or follow the repository's established mirrored-test convention.
- Test slices through public contracts where practical; test private modules directly only when their behavior warrants focused coverage.
- Keep test helpers at the narrowest useful scope. Promote only business-agnostic helpers to `shared` test support.
- For architecture changes, verify import boundaries with the repository's linter or architecture checker in addition to behavioral tests.

## Common Design Smells

- Empty layers or segments created for symmetry.
- `shared/components`, `shared/hooks`, `shared/types`, or `shared/utils` used as dumping grounds.
- A feature for every button click or CRUD operation.
- Entity slices that model API tables rather than useful product concepts.
- Pages importing other pages, features importing other features, or widgets importing other widgets.
- Deep imports into another slice to avoid updating its public API.
- Wildcard barrel exports.
- A slice importing from its own `index.ts`.
- Moving business logic to `shared` solely to bypass dependency rules.
- Framework route files containing the entire screen while the FSD page is only a wrapper.
