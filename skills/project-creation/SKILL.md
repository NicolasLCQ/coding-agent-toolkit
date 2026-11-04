---
name: project-creation
description: Create or initialize a new software project with the technology's latest stable version using its official documentation, scaffolding scripts, generators, and tools. Applies to standalone projects and new projects within an existing repository, not ordinary changes to an initialized project.
---

# Project Creation

## Official initialization

- Always use the latest stable release of the selected technology available at project creation time. Verify that release using current official release information; do not rely on memory, locally installed versions, generator defaults, or an unverified `latest` tag. Exclude alpha, beta, release candidate, nightly, canary, and other prerelease builds. Do not select an older LTS release when a newer stable release exists.
- If a repository requirement or environment limitation prevents using the latest stable release, report the blocker. Do not silently downgrade or modify existing projects to resolve it.
- Consult the current official project-creation documentation for the selected technology and version before choosing commands. Use documentation published by its maintainers; do not substitute remembered commands or third-party tutorials for the official procedure.
- Use the official initialization scripts, CLI tools, generators, or templates recommended by that documentation. Do not manually recreate scaffolding when an official creation tool is available.
- Verify the tool or package's identity against the official documentation before executing it. Use official tooling that supports the selected stable release and follow its documented prerequisites, supported runtime versions, and command options while respecting repository tooling.
- If no official generator exists, follow the official manual initialization procedure. If the official procedure cannot be accessed or executed, report the blocker rather than substituting an unofficial tool or handwritten scaffold.

## Adaptation and verification

- Inspect the destination before generation and preserve existing files. Do not use overwrite or force options to resolve a collision without authorization.
- Use generator options corresponding to the user's request and the official initialization procedure.
- Generate the project first, verify that its configuration and resolved dependency metadata target the selected latest stable release, then adapt the generated files to the requested functionality and repository conventions. Preserve required framework configuration and generated dependency metadata.
- Run the applicable setup and verification commands documented for the generated project, such as dependency installation and build or tests. Report any verification that could not complete.
- In the handoff, link the official documentation and release information used, state the selected stable version, initialization command, and any subsequent adaptations, and summarize verification results.
