# Architecture and Boundaries

## Scope

Use this architecture for React JavaScript and TypeScript files (`*.js`, `*.ts`, `*.jsx`, and `*.tsx`). Structure the application into six main directories: `api`, `app`, `config`, `pages`, `shared`, and `widgets`.

## Directory Responsibilities

### `api`

Contains all code responsible for external communication. External systems include HTTP APIs, SDKs, browser storage used as remote state, analytics clients, and any third-party service.

- `clients/` defines one client for each external service.
- `services/` defines one function for each external use case. Every service function uses a client to call the required external service.
- `hooks/` defines a hook wrapping each service for UI consumption.
- `api` is the only layer allowed to communicate with external systems.
- Authorized React entry points use only hooks from `api/hooks` to call external services. They must not use clients or services directly.

### `app`

Contains application-wide composition and setup.

- `[ApplicationName]App.tsx` is the JavaScript/TypeScript application entry point.
- `providers/` contains the application providers.
  - A provider-owned hook that reads a provider context stays in the corresponding `[ProviderName]Provider.tsx` file and is exported through `app/providers`.
- `router/` contains the application router.
- `router/Routes/RootRouteObject.tsx` defines the router's base routes.
- `styles/` contains global CSS.

### `config`

Contains runtime application configuration shared by `app` and `api`.

- Contains and exports `appsettings.[env].json` files.
- Must not import from `app`, `pages`, `widgets`, `shared`, or `api`.

### `pages`

Contains the route-level application screens.

- Each page has a `[PageName]Page/` directory containing `[PageName]Page.tsx`.
- A page directory contains one `[ComponentName]/` directory for each custom component local to that page.
- Page-specific child components receive information through props.
- The route-level page controls the data and passes it to its child components.

### `shared`

Contains generic reusable application code.

- `components/` contains reusable components.
  - If the application uses an external component or design system, wrap every external component in `shared/components` before using it elsewhere.
- `hooks/` contains reusable hooks that do not depend on application providers.
- `types/` contains reusable types and interfaces.

### `widgets`

Contains shared, business-oriented UI blocks composed of shared components and API data. Widgets may be used by several pages, but each widget stays focused on one visible feature or section.

## Reference Structure

```text
.
├── index.html
├── docs/
├── public/
│   ├── documents/
│   └── images/
└── src/
    ├── index.tsx
    ├── api/
    │   ├── index.ts
    │   ├── clients/
    │   │   ├── index.ts
    │   │   └── [ServiceName]Client.ts
    │   ├── services/
    │   │   ├── index.ts
    │   │   └── [featureName].ts
    │   └── hooks/
    │       ├── index.ts
    │       └── use[FeatureName]Query.ts
    ├── config/
    │   ├── index.ts
    │   └── appsettings.[env].json
    ├── app/
    │   ├── index.ts
    │   ├── [ApplicationName]App.tsx
    │   ├── providers/
    │   │   ├── index.ts
    │   │   └── [providerName]-provider/
    │   │       ├── index.ts
    │   │       └── [ProviderName]Provider.tsx
    │   ├── router/
    │   │   ├── index.ts
    │   │   ├── [ApplicationName]Router.ts
    │   │   └── Routes/
    │   │       ├── index.ts
    │   │       └── RootRouteObject.tsx
    │   └── styles/
    │       └── global.css
    ├── pages/
    │   ├── index.ts
    │   └── [PageName]Page/
    ├── shared/
    │   ├── components/
    │   │   ├── index.ts
    │   │   └── [ComponentName]Component/
    │   │       ├── [ComponentName]Component.module.css
    │   │       ├── [ComponentName]Component.tsx
    │   │       └── index.ts
    │   ├── hooks/
    │   │   ├── index.ts
    │   │   └── [hookName].ts
    │   └── types/
    │       ├── index.ts
    │       └── I[TypeName].ts
    └── widgets/
        └── [WidgetName]/
            ├── index.ts
            ├── [WidgetName].module.css
            └── [WidgetName].tsx
```

## Dependency Matrix

Keep dependencies flowing according to these authorized edges:

```text
app -> pages
app -> api/hooks
app -> config
app -> shared
app -> widgets
pages -> app/providers       # provider hooks only
pages -> api/hooks
pages -> shared
pages -> widgets
widgets -> app/providers     # provider hooks only
widgets -> api/hooks
widgets -> shared
api/hooks -> api/services
api/services -> api/clients
api/clients -> config
```

Apply these rules:

1. `app` may import from `pages`, `shared`, `widgets`, `config`, and `api/hooks` only when wiring global concerns such as providers or routing. Providers may call `api/hooks` when external data is needed to initialize or expose application-level state.
2. Provider hooks that expose provider context, such as `useNotification`, must be defined in the owning `[ProviderName]Provider.tsx` file under `app/providers/[providerName]-provider` and exported by `app/providers`. Do not put them in `shared/hooks` or a separate hook file.
3. `pages` may import from `widgets`, `shared`, `api/hooks`, and provider hooks from `app/providers`. Pages coordinate data and layout, but must not retain reusable UI logic that belongs in `widgets` or `shared`.
4. `widgets` may import from `shared`, `api/hooks`, and provider hooks from `app/providers`. Widgets must not import from `pages` or other `app` modules.
5. `shared` must not import from `pages`, `widgets`, `app`, or `api`. Shared code stays generic and stable, and wraps every external component used by the application.
6. `api/hooks` may import from `api/services`.
7. `api/services` may import from `api/clients`.
8. `api/clients` contains external-communication setup and may import runtime configuration from `config`.
9. `api` must not import from `app`, `pages`, `widgets`, or `shared`.
10. `config` must not import from `app`, `pages`, `widgets`, `shared`, or `api`.
11. Prefer public `index.ts` exports for cross-folder imports. Avoid deep imports into another module's private files unless the folder explicitly exposes that file as part of its contract.
12. Keep circular dependencies out of the codebase. If two modules need each other, extract the shared contract into `shared`.

Imports from `pages` or `widgets` to provider hooks in `app/providers` are the only declared upward exception. Keep the exception restricted to exported provider-context hooks and ensure the concrete module graph remains acyclic.

## Data-Fetching Boundaries

Only application providers, route-level pages, and root widgets may call hooks from `api/hooks`.

Allowed callers:

- `app/providers/[providerName]-provider/[ProviderName]Provider.tsx`
- `[PageName]Page.tsx`
- `[WidgetName].tsx`

Disallowed callers:

- shared components
- page-specific child components
- widget child components
- presentational components

Child components receive all external data through props.

## Cross-Folder Imports

This section verifies import paths; it does not grant permission for dependencies that the dependency matrix forbids.

An import must not go deeper than one of these public boundaries:

- `api/clients`
- `api/services`
- `api/hooks`
- `app/providers`
- `app/router`
- `app/styles`
- `config`
- `pages`
- `shared/components`
- `shared/hooks`
- `shared/types`
- `widgets`

Allowed:

```ts
import Page1 from "pages";
```

Not allowed:

```ts
import Page1 from "pages/Page1";
import Page1 from "pages/Page1/Page1.tsx";
```
