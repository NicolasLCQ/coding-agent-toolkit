# Unit-testing strategy

## Coverage and isolation

- Cover every production method with unit tests.
- Cover every possible path and every possible input combination for the tested method.
- Keep tests independent from one another.
- Keep tests deterministic: the same input must always produce the same result.
- Replace every dependency with a test double.
- Never use the real database.
- Do not fake a database except when testing the database layer itself.
- Put all paths for one tested method in one test file.
- Name the file `TestedMethod_Tests.cs`.

## Test cases and names

- Use explicit data that specifically proves the case under test.
- Give each test a clear name such as `TestedMethod_Should_ExpectedBehavior_When_Condition`.
- Create case-specific values in the test's Arrange phase.
- Verify results and relevant dependency interactions in the Assert phase.

## Test structure

Structure every test in three explicit phases: Arrange the case-specific inputs and test doubles, Act by invoking the tested method, then Assert the result and relevant interactions.

## Suggested solution structure

```text
/src
|-- [ApplicationName].sln
`-- [ApplicationName].UnitTests/
    |-- [ApplicationName].UnitTests.csproj
    |-- TestedMethod1_Tests.cs
    |-- TestedMethod2_Tests.cs
    `-- TestedMethod3_Tests.cs
```

