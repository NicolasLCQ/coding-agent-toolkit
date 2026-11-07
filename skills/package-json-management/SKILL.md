---
name: package-json-management
description: Create, edit, or review package.json with exact dependency versions, the latest stable direct dependencies, compatible stable transitive overrides, and a consistent package manager lockfile.
---

# Package.json Management

## Version policy

- Apply this policy to every registry dependency in `dependencies`, `devDependencies`, `optionalDependencies`, and `peerDependencies` in the manifests being managed, including workspace manifests within the task's scope.
- Always declare a single exact version, such as `"1.2.3"`. Do not use caret or tilde ranges, inequalities, unions, wildcards, partial versions, or distribution tags such as `latest`.
- Apply exact pinning to `peerDependencies` even for published libraries. Do not replace exact peer versions with compatibility ranges. Preserve optional peer metadata.
- Always use the latest stable release available when performing the task, including a newer major release. Exclude alpha, beta, release candidate, nightly, canary, and other prerelease builds. Do not limit updates to the currently declared range or major version.
- Verify versions using live metadata from the project's configured registry and official release information when needed. Do not rely on memory, an installed version, cached metadata, or an unverified `latest` tag. Use the package manager's version inspection capabilities and established semantic-version tooling rather than lexical version sorting.
- If release information is unavailable, report that freshness could not be verified. Do not invent a version or claim that existing pins are current.

## Changes and compatibility

- Inspect the existing package manager, registry configuration, workspace structure, and lockfile before making changes. Keep the project's package manager and lockfile format.
- Check all four dependency sections in each managed manifest, rather than updating only the dependency being added. During a review, report violations without modifying files unless changes are requested.
- Preserve package identity, dependency sections, and local dependency relationships. Registry aliases must retain their target package and pin its version exactly. For `workspace:`, `file:`, `link:`, Git, or URL dependencies, do not silently convert them into registry packages or invent a stable release. If the requested pinning policy requires changing such a source, ask how that dependency should be handled before changing it.
- Check runtime requirements and peer compatibility for the selected latest stable versions. Align declarations of the same peer used for development and testing with the exact peer version.
- If the latest stable releases conflict with each other or require a migration outside the authorized scope, report the concrete blocker and the required decision. Do not silently downgrade, widen peer ranges, use prereleases, or bypass compatibility checks with force options.
- Use the package manager's exact-save option when adding or updating packages, then inspect the resulting manifest; do not assume that this option also handles peer declarations. For npm, see the official [save-exact documentation](https://docs.npmjs.com/cli/using-npm/config#save-exact). Avoid changing global package-manager configuration.

## Transitive dependency overrides

- Pin transitive registry dependencies managed by the task through npm's root-level `overrides`, or the existing package manager's equivalent. Use a single exact version for each override.
- Select the latest stable release compatible with every consuming dependency affected by the override. Verify live registry metadata, declared dependency ranges, peer requirements, and runtime requirements. The latest compatible stable release may be older than the latest stable release overall; this exception applies to transitive overrides, not direct dependency declarations.
- Use a global override only when the selected version satisfies all affected consumers. When consumers require incompatible version ranges, use scoped overrides for the relevant dependency branches, selecting the latest compatible stable release independently for each branch. Do not force one version across incompatible consumers.
- Respect package-manager restrictions on overrides of direct dependencies. Keep any override affecting a direct dependency consistent with its exact declaration; do not use an override to bypass the direct dependency version policy.
- If no compatible stable release exists or compatibility cannot be established, report the affected consumers and the blocker rather than forcing an override. Regenerate the lockfile and run the relevant checks after changes; satisfying declared ranges alone does not establish runtime compatibility. See the official [npm overrides documentation](https://docs.npmjs.com/cli/configuring-npm/package-json#overrides).

## Verification

- Regenerate the existing lockfile through the project's package manager after dependency changes. An exact declaration does not replace a lockfile; preserve transitive resolution and integrity metadata through the package manager rather than hand-editing it.
- Verify that every managed registry declaration is exact and matches the verified latest stable version, including peer declarations. For transitive overrides, verify the latest compatible stable version for each affected branch. Check installation and dependency compatibility, then run the project's relevant build, type checks, lint, or tests.
- Report updated versions, verification results, and any unresolved blockers. Do not describe the work as complete if latest stable versions could not be verified or compatibility remains unresolved.
