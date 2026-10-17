---
name: csharp-bogus
description: Generate deterministic fake C# test data with Bogus, using reusable model fakers and case-specific rule overrides.
---

# C# Fake Data with Bogus

Apply this skill when C# tests need dynamically generated fake data with [Bogus](https://github.com/bchavez/Bogus).

Generated data must remain deterministic and must not make a test depend on uncontrolled time, randomness, or other chance. Seed the generator when needed, and explicitly override every property whose value matters to the case.

## Faker definitions

- For each model, create a public static helper class named `ModelFaker` in a helper file.
- Add a public static `ModelGenerator` method returning `Faker<Model>` and define rules for every model property.
- Keep faker defaults varied. For example, use `f.Random.Bool()` for a Boolean instead of fixing the shared rule to `true`.
- Never fix case-specific properties in the shared faker. Override them in the test's Arrange phase.
- Always use a lambda named `f` in `RuleFor`, even when its parameter is not otherwise needed. This prevents accidental reuse of the same object and keeps the code homogeneous.
- When model A contains model B, generate B through `ModelBFaker.ModelBGenerator().Generate()` rather than constructing `new ModelB()` directly.

```csharp
public static class ModelFaker
{
    public static Faker<Model> ModelGenerator()
    {
        return new Faker<Model>()
            .RuleFor(model => model.BooleanProperty, f => f.Random.Bool())
            .RuleFor(model => model.StringProperty, f => f.Random.String2(10))
            .RuleFor(model => model.IntProperty, f => f.Random.Number(1, 100));
    }
}
```

## Generating case data

- Call `Faker.Generate()` for one value.
- Call `Faker.Generate(count)` for multiple values.
- Before `Generate()`, call `RuleFor(model => model.Property, f => value)` in the Arrange phase to override values required by the case.
- Build the expected value from generated input when possible.

```csharp
Model model = ModelFaker.ModelGenerator()
    .RuleFor(value => value.BooleanProperty, f => true)
    .RuleFor(value => value.StringProperty, f => "foobar")
    .RuleFor(value => value.IntProperty, f => 3)
    .Generate();

ResultType expectedResult = ResultTypeFaker.ResultTypeGenerator()
    .RuleFor(value => value.Property, f => model.StringProperty)
    .Generate();
```
