---
name: csharp-xunit
description: Use xUnit as the C# test framework and apply its conventions for annotations, lifecycle setup, teardown, and asynchronous test signatures.
---

# C# xUnit Conventions

Use [xUnit](https://xunit.net/) when implementing or reviewing C# unit and integration tests.

## Conventions

- Use `[Fact]` for simple tests.
- Use `[Theory]` for parameterized tests.
- Use the test class constructor for setup that must run before each test.
- Use `IDisposable.Dispose` for teardown.
- Avoid static private setup functions. Prefer the constructor for shared per-test setup and generate case-specific variables in the Arrange phase.
- Use `async Task` for asynchronous tests and `void` for synchronous tests, as appropriate.
```csharp
[Fact]
public void TestedMethod_Should_ExpectedBehavior_When_Condition()
{
}

[Theory]
[InlineData(1)]
public void TestedMethod_Should_ExpectedBehavior_When_ParameterizedCondition(int value)
{
}
```

```csharp
[Fact]
public async Task TestedMethod_Should_ExpectedBehavior_When_AsynchronousCondition()
{
    await Task.CompletedTask;
}
```
