---
applyTo: '**'
title: General coding guidelines
description: 'Prefer suitable existing solutions and produce clear, readable, maintainable code.'
---

# General Coding Guidelines

## Objective

Produce code that is clear, readable, and organized into cohesive features and responsibilities.

Do not treat the existing implementation as a quality standard. Refactor or rewrite code when its structure, naming, or design does not meet these guidelines.

## Implementation Decision Order

Before implementing a capability, evaluate the following options in order:

1. Reuse, adapt, refactor, or rewrite an existing implementation in the codebase when it provides a suitable foundation.
2. Use a capability provided by the language, standard library, framework, or platform.
3. Use a suitable library or dependency that is already included in the project.
4. Add a suitable external library or dependency when it is reliable, secure, maintained, and compatible with the project.
5. Implement the capability directly when none of the previous options provides an appropriate solution.

Choose the first option that satisfies the requirement while preserving correctness, clarity, security, and maintainability. The presence of existing code or an installed dependency does not require its reuse when it is unsuitable.

Do not implement security-sensitive or standardized functionality from scratch when a well-established solution is available.

## Code Clarity and Structure

- Prefer clear, readable code over clever or unnecessarily compact code.
- Use names that communicate intent and match the conventions of the language and codebase.
- Organize code into cohesive features and responsibilities with clear boundaries. Separate unrelated responsibilities
- code must be self-explanatory

## Refactoring and Rewriting

Refactoring is encouraged when it improves the code affected by the requested change.

Do not preserve unclear structure, misleading names, unnecessary complexity, or poor abstractions merely because they already exist in the codebase. Rewrite the relevant code when that produces a clearer and more maintainable result.

Preserve defined functional behavior, public contracts, stored data, and compatibility unless the request explicitly changes them.

## Comments and Documentation

Prefer expressive code over comments that restate what the code does.

Add a comment or documentation when it communicates information that the code cannot express clearly, such as:

- the reason for a non-obvious implementation choice;
- a business, compatibility, security, or performance constraint;
- behavior imposed by an external system;
- a temporary workaround and the condition for removing it;
- documentation required for a public API or by the project.

Keep comments concise, accurate, and close to the code they explain.
