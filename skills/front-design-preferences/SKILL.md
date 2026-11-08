---
name: front-design-preferences
description: Apply frontend design preferences when implementing, changing, or reviewing application styles, centralizing all colors and fonts in one global file before using them throughout the application.
---

# Front Design Preferences

## Global colors and fonts

Define every application color and font family in a single global design file
before using it elsewhere in the application. Keep this file as the source of
truth for these values.

Reuse or adapt the project's existing global theme or design-token file. If none
exists, create one in the location appropriate to the project's architecture
and styling system. Use its native mechanism, such as CSS custom properties or
an exported theme object; do not introduce a styling dependency for this rule.

- Declare color values and font stacks, including fallback fonts, only in this
  file. Centralize custom font declarations or font-loader configuration there
  when applicable.
- Give tokens meaningful names that describe their purpose, such as
  `colorTextPrimary`, `colorSurface`, or `fontBody`.
- Reference these global tokens from components, pages, stylesheets, inline
  styles, and application-owned SVG styles. Do not repeat literal color values
  or font-family names outside the global file.
- Apply the same rule to interactive states, gradients, shadows, and theme
  variants: their colors must come from the global file as well.
- Reuse an existing token when it expresses the intended role. Define any needed
  new color or font token in the global file before adding its consumers.
- Load or expose the global definitions through the application's existing
  styling entry point or theme provider so all consumers can resolve them.

When changing existing styles, move affected literal colors and font families
into the global file and replace their usages with references. Preserve the
existing appearance unless a visual change is requested. Keep this work within
the requested scope.

## Verification

Check that affected application styles contain no locally declared literal
colors or font families, that their token references resolve, and that the
global definitions are available wherever they are consumed.
