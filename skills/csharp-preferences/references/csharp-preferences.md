# C# coding preferences

## Precedence and documentation

- Always apply `.editorconfig` before every rule in this reference.
- Add XML summary documentation, including parameters, return values, and possible exceptions, only on interfaces. Do not add this documentation to implementations or other classes unless `.editorconfig` or the repository requires it.

## Dependencies

- Microsoft dependencies may be used.
- Validate every non-Microsoft dependency before implementation. Check that it is suitable, maintained, secure, and compatible with the project.
- Prefer C# Foundation dependencies

## Technical preferences

- Use dependency injection.
- Prefer transient lifetime, then scoped lifetime. Use singleton when it is the best practice for the implementation.
- Use Minimal APIs.
- For ASP.NET Core Minimal APIs on supported framework versions, use `Microsoft.Extensions.Validation` for request validation. Declare field validation rules with `System.ComponentModel.DataAnnotations` attributes on request model properties, and register validation with `builder.Services.AddValidation()`.
- Prefer manual mappers implemented as extension methods.
- Name mapping extension methods `To{DestinationType}`: for objects of types `A` and `B`, use `a.ToB()` to map from `A` to `B` and `b.ToA()` to map from `B` to `A`.
- Keep one class per file.
- Do not put methods on models. Put model-related behavior in separate extensions or services as appropriate.
- Prefer asynchronous over synchronous methods.

