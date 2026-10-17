---
name: csharp-unit-tests
description: Define and apply an exhaustive C# unit-testing strategy covering paths, input combinations, isolation, determinism, and one test file per tested method.
---

# C# Unit Tests

Apply this skill to unit-test production methods and their possible paths and input combinations.

## Workflow

1. Inspect the method, its dependencies, and existing test strategy.
2. Enumerate every reachable path and every possible input combination, including failures and boundary cases defined by the product behavior.
3. Read [references/unit-testing.md](references/unit-testing.md) for coverage, isolation, structure, and naming rules.
4. Implement one test file per tested method, covering all of that method's paths.
5. Run the narrow test project, then any broader test command required by the repository.
