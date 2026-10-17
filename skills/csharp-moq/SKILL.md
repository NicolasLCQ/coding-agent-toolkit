---
name: csharp-moq
description: Apply Moq-specific mocking conventions in C# tests, including dependency substitution and interaction verification.
---

# C# Moq Conventions

Apply this skill when C# tests require mocked dependencies with [Moq](https://github.com/moq/moq4).

## Conventions

- Mock every dependency of a unit under test.
- Configure only the behavior required by the test case.
- Use `Verify` to assert mock interactions that form part of the expected behavior.
