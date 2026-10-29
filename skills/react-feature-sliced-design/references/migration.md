# Incremental Migration to FSD

Read this reference for an existing non-FSD codebase or a restructuring that spans several responsibilities. Do not turn an ordinary feature change into a repository-wide migration without user authorization.

## Sequence

### 1. Establish boundaries

Inspect imports, aliases, routes, providers, build configuration, and generated code. Define the target layer roots and configure a stable alias such as `@/` for `src/` if the project does not already have one.

Do not create all layers. Start with `app`, `pages`, and `shared`; add `widgets`, `features`, and `entities` only when the existing code reveals those responsibilities.

### 2. Extract pages from route files

Create one slice per routable screen. Keep framework route modules as thin adapters and move screen implementation into the page slice.

During this phase, prioritize visible ownership. Record page-to-page imports for later removal instead of obscuring them behind new barrels.

### 3. Separate application setup and foundations

Move application-wide initialization, providers, router wiring, and global styles to `app`.

Move only business-agnostic foundations to `shared`, such as the UI kit, transport client, environment parsing, route primitives, and focused libraries. Code used by one page stays with that page.

### 4. Organize by purpose

Within each page or slice, group code into useful segments such as `ui`, `api`, `model`, `lib`, and `config`. Replace technical buckets such as global `components`, `hooks`, `types`, `reducers`, and `utils` with ownership-based placement.

### 5. Remove same-layer cross-imports

For each page-to-page or other same-layer dependency:

1. keep or duplicate local presentation when the concepts evolve independently;
2. move generic infrastructure to `shared`;
3. extract stable domain representation to `entities`;
4. extract a user-valued reusable interaction to `features`;
5. extract a substantial reusable composition to `widgets`;
6. compose independent slices from a higher layer.

Do not move business logic to `shared` simply to make the import graph pass.

### 6. Introduce public APIs

Add an explicit `index.ts` to each slice and focused Shared entrypoints. Update consumers to use public APIs, remove deep imports, and keep intra-slice imports relative.

Avoid wildcard exports. Check for circular imports after changing barrels.

### 7. Enforce the architecture

Once a meaningful area follows FSD, add or tighten automated checks for:

- layer direction;
- same-layer slice isolation;
- forbidden deep imports;
- circular dependencies;
- runtime-specific server/client boundaries.

Apply enforcement to migrated areas first if a repository-wide rule would block unrelated delivery.

## Migration Completion Criteria

A migrated area is complete when:

- responsibilities have clear owners;
- imports follow the layer direction;
- same-layer slices are isolated;
- external consumers use public APIs;
- behavior is covered by the relevant existing or added tests;
- temporary exceptions are removed or explicitly documented with a bounded follow-up.

Do not declare the whole repository migrated merely because its top-level folders match FSD names.
