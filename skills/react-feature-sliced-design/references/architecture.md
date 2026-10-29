# Feature-Sliced Design Architecture

## Authority and Scope

These rules define the required architecture for React JavaScript and TypeScript application code. Treat every statement in this document as mandatory unless it explicitly defines an exception.

Feature-Sliced Design has exactly three structural levels:

1. **Layers** define scope and dependency direction.
2. **Slices** group code by product or business meaning.
3. **Segments** group code inside a slice by purpose.

Do not introduce another structural level that changes these responsibilities.

## Layers and Dependency Direction

The allowed layers, from highest to lowest, are:

```text
app
pages
widgets
features
entities
shared
```

Omit a layer when it is unused. Do not add, rename, reorder, or repurpose layers.

A module's imports are restricted to:

- modules inside its own slice;
- public APIs of slices on strictly lower layers.

A module must not import:

- a higher layer;
- a different slice on the same layer;
- another slice's private files.

The dependency surface is therefore fixed:

```text
app      -> pages, widgets, features, entities, shared
pages    -> widgets, features, entities, shared
widgets  -> features, entities, shared
features -> entities, shared
entities -> shared
shared   -> shared only
```

An allowed dependency is not a required dependency. Every module must use only the dependencies required by its responsibility.

`app` and `shared` are the only layers without slices. They contain segments directly. Same-layer imports within `app` or within `shared` are valid only when they remain acyclic.

## Layer Responsibilities

### `app`

`app` owns application-wide composition and initialization:

- entrypoints and bootstrap;
- router configuration and framework adapters;
- global providers and store initialization;
- global styles;
- application-wide analytics, error handling, and configuration wiring.

`app` must not contain business use cases. It only composes the application and connects dependencies.

### `pages`

Each `pages` slice represents one routable screen or one substantial nested-route screen. A page owns the composition of lower-layer modules and all route-specific loading, errors, metadata, layout, and behavior local to that page.

A page slice must not import another page slice. Framework route files must be thin adapters that only render or re-export a page public API.

### `widgets`

Each `widgets` slice represents one large, self-contained application block that delivers a complete page section or use case, such as a header, checkout summary, or activity feed.

Code belongs in `widgets` only when it composes multiple lower-layer concepts or when the same substantial page section is reused. A visual container that does not meet either condition must remain in the owning page, feature, or entity.

### `features`

Each `features` slice represents one user-visible interaction with independent product value, such as signing in, applying a coupon, or changing an avatar.

An action or component without independent product meaning must remain in its owning page or widget. Reuse alone does not make code a feature.

### `entities`

Each `entities` slice represents one business concept, such as `user`, `product`, or `order`. An entity owns the domain types, validation, state, API operations, and reusable visual representation of that concept.

A workflow involving multiple entities must live in `features`, `widgets`, or `pages`. Entity UI must accept higher-level behavior through props, slots, callbacks, or other explicit composition points. It must not import that behavior.

### `shared`

`shared` owns reusable foundations that contain no application-specific business rules. Its allowed responsibilities are:

- `ui`: UI-kit components and visual primitives;
- `api`: transport clients and generic backend interaction primitives;
- `lib`: focused, domain-neutral libraries such as dates, text, or colors;
- `config`: environment parsing and global configuration;
- `routes`: route constants and matching primitives;
- `i18n`: translation infrastructure.

Code with a single owner must remain with that owner. Move code to `shared` only after it has multiple consumers and a stable, domain-neutral responsibility. `shared` must never be used as a miscellaneous or temporary destination.

## Slices

`pages`, `widgets`, `features`, and `entities` contain slices. Every slice name must use product or business language. Use kebab-case unless the repository already enforces another naming convention:

```text
pages/product-details
widgets/order-summary
features/apply-coupon
entities/product
```

Each slice must have one cohesive responsibility and must be independently changeable. Different slices on the same layer must remain isolated.

If two same-layer slices require one another or always change together, the boundary is invalid. Resolve it by doing exactly one of the following:

1. merge them when they form one responsibility;
2. move genuinely shared domain logic to the correct lower layer;
3. compose them from a higher layer.

Place related slices in a visual slice group only when the grouping improves navigation, for example `features/post/like`. The group is organizational only: it must not contain code, expose a public API, or permit cross-imports between its slices.

## Segments

Segments describe responsibility, never syntax. Use these conventional segment names when the corresponding responsibility exists:

- `ui`: rendering, appearance, and UI-specific formatting;
- `model`: domain state, schemas, stores, selectors, and business rules;
- `api`: slice-specific requests, DTOs, and mappers;
- `lib`: focused internal code owned by the slice;
- `config`: slice-specific configuration and feature flags.

Create only the segments that contain code. A custom segment is allowed only when none of the conventional names describes its responsibility accurately.

Do not create broad type-based segments named `components`, `hooks`, `types`, `helpers`, or `utils`.

Types, hooks, constants, and tests must be colocated with the responsibility that owns them. A query hook belongs in `api`; a state hook belongs in `model`; a rendering hook belongs in `ui`.

## Public APIs

Every slice must expose one explicit public contract through its root `index.ts`:

```ts
// features/apply-coupon/index.ts
export { ApplyCouponForm } from "./ui/ApplyCouponForm";
export { useApplyCoupon } from "./model/useApplyCoupon";
```

All external consumers must import from the slice root:

```ts
import { ApplyCouponForm } from "@/features/apply-coupon";
```

Wildcard exports are forbidden. The public API must export only symbols required by external consumers.

Modules inside a slice must import one another through relative full paths. They must not import through their own slice `index.ts`, because that creates circular-import risk.

Because `shared` contains segments rather than slices, every focused module in `shared` must expose its own public entrypoint. Do not create a monolithic `shared/ui` or `shared/lib` barrel. Use focused imports:

```ts
import { Button } from "@/shared/ui/button";
```

Create separate client, server, or platform entrypoints whenever importing one runtime's code into another runtime would be invalid.

## Same-Layer Relationships

Cross-imports between different slices on the same layer are forbidden. Resolve every attempted cross-import in this order:

1. Merge the slices if they are one responsibility.
2. Move shared domain-only logic to the correct lower layer.
3. Compose independent slices from a higher layer through props, slots, callbacks, context, or dependency injection.
4. Duplicate small presentation code when the concepts have separate ownership and must evolve independently.

The only exception is an explicit cross-reference API between entity slices. The source entity must expose a narrow `@x` entrypoint named for the consuming entity:

```text
entities/
  artist/
    @x/song.ts
  song/
```

```ts
import type { Artist } from "@/entities/artist/@x/song";
```

An `@x` entrypoint is valid only when all of these conditions hold:

- both slices are in `entities`;
- merging the entities would destroy distinct business ownership;
- moving the contract to `shared` would introduce business meaning into `shared`;
- the entrypoint exposes only the minimum contract required by the named consumer;
- the coupling is documented next to the entrypoint.

Do not use `@x` in any other layer or as a general public API.

## Required Structure

Place code in this structure. Omit layers and segments that contain no code; do not create empty directories.

```text
src/
├── app/
│   ├── providers/
│   ├── routes/
│   └── styles/
├── pages/
│   ├── page-1/
│   │   ├── api/
│   │   ├── model/
│   │   ├── ui/
│   │   └── index.ts
│   ├── page-2/
│   └── page-3/
├── widgets/
│   ├── widget-1/
│   │   ├── api/
│   │   ├── model/
│   │   ├── ui/
│   │   └── index.ts
│   ├── widget-2/
│   └── widget-3/
├── features/
│   ├── feature-1/
│   │   ├── api/
│   │   ├── model/
│   │   ├── ui/
│   │   └── index.ts
│   ├── feature-2/
│   └── feature-3/
├── entities/
│   ├── entity-1/
│   │   ├── api/
│   │   ├── model/
│   │   ├── ui/
│   │   └── index.ts
│   ├── entity-2/
│   └── entity-3/
└── shared/
    ├── api/
    ├── config/
    ├── lib/
    ├── routes/
    └── ui/
```

`page-1`, `page-2`, and `page-3` represent distinct page slices. The complete internal structure is shown only for `page-1`; every other page slice follows the same rules and contains only the segments it needs. Apply the same reading to `widget-*`, `feature-*`, and `entity-*`.

`app` and `shared` contain segments directly and never contain slices. The displayed segment names define their placement; they do not require empty directories.

The layer order, slice boundaries, segment semantics, dependency direction, and public API rules are mandatory.

## Architecture Review Requirements

An architecture review passes only when every statement below is true:

- Every module has one clear owner and the narrowest valid scope.
- Every import points to a lower layer or remains inside the same slice.
- Different slices on the same layer are isolated, except for a valid entity `@x` contract.
- Every external consumer imports through an explicit public API.
- `app` and `shared` contain segments directly and no fake business slices.
- Every segment name describes a responsibility.
- `shared` contains no application-specific business logic.
- Framework entrypoints are thin adapters with no business responsibility.
- The dependency graph is acyclic.

If any statement is false, the architecture is non-compliant and must be corrected before the change is complete.
