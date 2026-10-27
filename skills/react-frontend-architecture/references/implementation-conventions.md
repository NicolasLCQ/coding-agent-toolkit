# Implementation Conventions

Read this reference when creating or reviewing components, hooks, providers, styles, clients, services, API routes, or names. The placement and dependency rules remain defined in [architecture.md](architecture.md).

## Naming

Use clear and consistent names.

### Shared components

- Use `PascalCase`.
- End the name with `Component`.

### Hooks

- Use `camelCase`.
- Start the name with `use`.

### Providers

- Use `kebab-case` for provider directories.
- End provider-directory names with `provider`.

## Components

1. Keep components small and focused on one rendering responsibility.
2. Use CSS modules for component-level styling. Reserve global CSS for resets, tokens, typography defaults, and application-wide layout primitives.
3. Reuse shared components before creating page-specific alternatives.
4. Move a page-specific component to `widgets` or `shared` only after it is reused or clearly belongs to a broader UI concept.
5. Keep data fetching out of presentational components. Application providers, route-level pages, or root widgets fetch data through `api/hooks` and pass it to child components through props.
6. Implement components as arrow functions and type their props parameter with an `I[ComponentName]Props` interface.

## External API Access

1. Keep global HTTP configuration in `api/clients`.
2. `api/clients` is the only directory allowed to configure low-level external clients.
3. `api/clients` may import runtime configuration from `config`.
4. `api/services` is the only directory allowed to call external clients directly.
5. Expose one request function per API use case. Define every request function as a service in `api/services`.
6. Wrap every service with a hook in `api/hooks`.
7. React components consume external data only through hooks exported from `api/hooks`.
8. Centralize API route strings as constants.
