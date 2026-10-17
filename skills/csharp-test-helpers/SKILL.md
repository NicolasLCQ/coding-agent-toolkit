---
name: csharp-test-helpers
description: Organize reusable C# test helpers into a dedicated project containing fakers, constants, and factories shared by test projects.
---

# C# Test Helper Organization

Apply this skill when creating or reorganizing reusable helpers shared by C# test projects.

Use this project structure:

```text
/src
|-- [ApplicationName].sln
`-- [ApplicationName].TestHelpers/
    |-- [ApplicationName].TestHelpers.csproj
    `-- Helpers/
        |-- Fakers/
        |   |-- Model1Faker.cs
        |   `-- Model2Faker.cs
        |-- Consts/
        `-- Factories/
```
