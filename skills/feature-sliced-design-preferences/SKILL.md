---
name: feature-sliced-design-preferences
description: Apply project-specific Feature-Sliced Design conventions when implementing, refactoring, or reviewing FSD frontend code, including page and component decomposition into nested folders, API endpoints and hooks, page logic in model, and third-party component wrappers in shared.
---

# Feature-Sliced Design Preferences

Apply these conventions alongside the `feature-sliced-design` skill. These
project-specific rules take precedence over its general segment guidance
and examples. Preserve FSD layer dependencies, slice boundaries, and public APIs.

## API segments

Every `api/` segment must contain these directories:

- `endpoints/`: Functions that call the backend API. Keep request construction,
  transport handling, and API-specific input and response types here.
- `hooks/`: Hooks that wrap the endpoint functions for use in the application.
  Use the project's existing data-fetching library and conventions.

Keep endpoint functions independent of UI components and hooks. API hooks
provide the application-facing integration with those functions; page-specific
workflows and business decisions belong in the page's `model/` segment.

Apply this structure wherever an API segment belongs under FSD, including
page-local API segments and `shared/api/`. Preserve ownership rather than
moving all endpoints to Shared. These directories are subdivisions of `api/`,
not new segments or slices.

## Page logic

Place all page logic in `pages/<page>/model/`: page state, form handling,
validation, derived values, business rules, event handlers, and workflow
orchestration. Page model hooks compose the API hooks when data access is needed.

Split page logic into multiple focused hooks, with one hook per functionality.
Each hook owns the state, derived values, and handlers for that functionality.
Name hooks after their responsibility, such as `use-profile-form` or
`use-profile-avatar`. Do not gather unrelated functionality into a single
`usePage` or `use-profile-page` hook. A page with multiple functionalities
must consume their focused hooks rather than one hook containing all page logic.

Keep `pages/<page>/ui/` focused on rendering and binding model-provided state
and handlers to components. Move page logic out of JSX and UI component bodies
into the page model. Backend calls and their technical hook wrappers remain
in `api/endpoints/` and `api/hooks/` respectively.

## Page and component decomposition

Split pages and components into focused child components corresponding to
their distinct UI parts. Keep the parent focused on composing those parts
rather than implementing all of their markup in one file.

Pass all information needed by child components explicitly through props,
including data, state, derived values, display options, and event callbacks.
The parent consumes the relevant model hooks and passes their values and
handlers down through props. Child components must not retrieve these inputs
themselves through API calls, model hooks, context, or global stores. Apply
this rule at every level of the component hierarchy.

Give each page or component its own directory containing its main TSX file.
Place each child component in a dedicated subdirectory of its parent, with
the child's TSX file inside. Apply this structure recursively when a child
itself contains distinct UI parts. Use responsibility-based names and follow
the project's file naming convention.

```text
component/
  component-name.tsx
  first-part/
    first-part.tsx
  second-part/
    second-part.tsx

page/
  page-name.tsx
  first-section/
    first-section.tsx
  second-section/
    second-section.tsx
```

These directories belong inside the owning `ui/` segment; they do not
introduce FSD slices or segments. Keep parent-specific children local to
their parent. Place components reused outside that parent at the appropriate
FSD ownership level and respect public APIs. Keep page logic in `model/`
as described above, including logic used by extracted child components.

## Third-party components

Wrap third-party UI components in `shared/ui/` before using them in the
application. Application code imports the local wrapper through its public
API; only the wrapper imports the third-party component it encapsulates.

Create an actual wrapper component rather than a bare re-export. Keep the
wrapper focused on adapting the external component for application use,
without page-specific or business logic. Reuse an existing wrapper when one
already covers the component.

## Example structure

```text
src/
  pages/
    profile/
      api/
        endpoints/get-profile.ts
        hooks/use-profile.ts
      model/
        use-profile-form.ts
        use-profile-avatar.ts
      ui/
        profile-page/
          profile-page.tsx
          profile-form/
            profile-form.tsx
          profile-avatar/
            profile-avatar.tsx
      index.ts
  shared/
    ui/
      button/
        button.tsx
        index.ts
```

Here, `use-profile` wraps `get-profile`. The model hooks `use-profile-form`
and `use-profile-avatar` each own their respective functionality, and
`profile-page` renders their state and delegates events to their handlers.
The shared Button wrapper encapsulates the external library's Button.
