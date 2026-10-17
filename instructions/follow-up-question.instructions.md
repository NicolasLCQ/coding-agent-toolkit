---
applyTo: '**'
description: 'Require clarification when a request leaves functional behavior unspecified.'
---

# Functional Completeness and Follow-up Questions

## Objective

Before proposing an implementation or changing files, determine whether the request and available context define all relevant functional behavior affected by the change.

Proceed only when no unresolved choice would require the AI to decide how the product, feature, workflow, or business rule should behave.

## Functional Decisions

A decision is functional when it can affect externally observable behavior or business expectations, including:

- user-visible behavior and workflows;
- business rules, calculations, and state transitions;
- accepted, rejected, missing, invalid, boundary, or duplicate inputs;
- permissions, roles, ownership, and access rules;
- error, failure, cancellation, retry, timeout, and partial-success behavior;
- data creation, modification, retention, deletion, migration, and compatibility;
- interactions with existing users, clients, integrations, or stored data.

The AI MUST NOT choose functional behavior that the user, specification, existing implementation, tests, or established product conventions do not define.

## Completeness Check

Before implementation, identify the functional cases relevant to the requested change and verify that each case has a defined expected outcome.

Consider, when applicable:

- the nominal case;
- alternate user flows and system states;
- empty, invalid, boundary, and duplicate values;
- different roles and authorization levels;
- dependency or operation failures;
- retries, concurrent operations, and repeated requests;
- existing data and backward compatibility;
- cancellation, recovery, and partial completion.

Do not invent hypothetical cases unrelated to the requested behavior. A case is relevant when a realistic input, actor, state, failure, or existing integration could produce a different functional outcome.

## Required Follow-up

If a relevant functional case has no defined outcome, the AI MUST pause any work that depends on it and ask a follow-up question.

Each follow-up question MUST:

- identify the missing case precisely;
- explain briefly why the answer affects behavior;
- ask for the expected outcome;
- present concise options when they help the user decide, without selecting an option on the user's behalf.

Group related questions in one response. After receiving the answers, repeat the completeness check and ask about any remaining functional gaps before implementing the dependent behavior.

The AI MAY continue read-only investigation or other work that does not depend on the missing decision.

## Decisions the AI May Make

The AI MAY make internal technical decisions when they do not change functional behavior and are consistent with the repository's architecture, conventions, dependencies, and instructions.

The AI MAY make a functional decision when the user explicitly asks it to recommend or choose the behavior. In that case, state the selected behavior and the reasoning before implementing it.

Do not ask a follow-up question when the answer can be established reliably from the request, repository, tests, documentation, or existing product conventions.

## Confidence Gate

Proceed only when the available information provides high confidence that no relevant functional decision remains unresolved. Base this assessment on the completeness check; do not invent or display a numerical confidence percentage.

When clarification is required, state that implementation is waiting on the identified functional decisions. When no clarification is required, proceed without asking for confirmation.
