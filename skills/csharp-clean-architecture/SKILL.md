---
name: csharp-clean-architecture
description: Design, implement, refactor, or review C# solutions that use the prescribed API, Application, and Gateway Clean Architecture layers and project-reference direction.
---

# C# Clean Architecture

Apply this skill when a C# change affects solution structure, layer ownership, cross-layer mapping, external-service access, or project references.

## Workflow

1. Inspect the solution, project references, existing conventions, and affected behavior before choosing file placement.
2. Read [references/csharp-clean-architecture.md](references/csharp-clean-architecture.md) before designing, implementing, refactoring, or reviewing layer boundaries.
3. Keep business logic and business errors in Application, transport concerns in API, and external-system concerns in Gateway.
4. Keep mapping at the boundaries: API maps API models to Application models; Gateway maps external models to Application models. Application does not map between layers.
5. Verify the final project-reference direction and confirm that Application references no other solution project.
