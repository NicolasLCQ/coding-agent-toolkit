---
name: csharp-integration-tests
description: Define and apply an exhaustive C# integration-testing strategy for API and batch entrypoints, using separate guidance for each entrypoint type.
---

# C# Integration Tests

Apply this skill when integration coverage is required for an API endpoint or a batch entrypoint.

## Shared strategy

- Cover every application entrypoint with integration tests.
- Cover every possible path and every possible argument combination.
- Cover 100% of the application through the integration suite.
- Keep tests independent from one another.
- Keep tests deterministic: the same input must always produce the same result.
- Never use the real database. Use an isolated fake database populated with controlled test data.
- Use explicit data that specifically proves the case under test.
- Generate dynamic test data without depending on uncontrolled time, randomness, or other chance.
- Give each test a clear name such as `Entrypoint_Should_ExpectedBehavior_When_Condition`.
- Put all paths for one tested entrypoint in one test file.
- Structure every test in three explicit phases: Arrange, Act, and Assert.

## Entrypoint-specific guidance

- For an API endpoint, read [references/api-integration-testing.md](references/api-integration-testing.md).
- For a batch entrypoint, read [references/batch-integration-testing.md](references/batch-integration-testing.md).
- When a task covers both types, read both references and apply each only to its corresponding entrypoint.

## Workflow

1. Inspect the entrypoint, its hosting or execution mechanism, its dependencies, its database boundary, and the existing integration-test strategy.
2. Inventory every affected entrypoint and enumerate every possible argument combination and path.
3. Read only the entrypoint-specific references required by the task.
4. Implement one integration-test file per tested entrypoint.
5. Run the narrow integration-test project, then any broader test command required by the repository.
