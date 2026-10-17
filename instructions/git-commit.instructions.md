---
applyTo: '**'
description: 'Commit message conventions based on the Conventional Commits specification.'
---

# Commit conventions

## 1. Structure

Commits must be formatted according to the Conventional Commits specification.
```
type(scope)!: description

body

footer
```

### type

- build: Changes that affect the build system or external dependencies
- ci: Changes to our CI configuration files and scripts
- docs: Documentation only changes
- feat: A new feature
- fix: A bug fix
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- test: Modifying a test project


### scope

A scope MUST consist of a noun describing the section of the codebase concerned by the change.

### !

The `!` character MUST be placed immediately before the `:` in case of breaking changes.

### description

The description is a short global summary of the code changes

### body

A longer commit body MAY be provided when the short description is insufficient to explain the context and reason for the change. It SHOULD NOT merely repeat the diff.
The body MUST begin one blank line after the description.
A commit body is a list of details about the code changes.
Each detail MUST be a bullet point, starting with a - character, followed by a space and then a sentence describing the specified detail.

### footer

One or more footers MAY be provided one blank line after the body. Each footer MUST consist of a word token, followed by either a `: ` or ` #` separator, followed by a string value.

## 2. examples

### General commits

1. Create an add button and functionalities to add a new user
```
feat(user): add user

- add button to open a modal to add a new user
- add route to add a new user
```

### Breaking change commits

1. Remove the user profile page and all related code
```
refactor(user)!: remove user profile page

- remove user pages
- remove user functionality
- remove user api routes

BREAKING CHANGE: Remove the user detailed information table in database
BREAKING CHANGE: Remove the user detailed information id from the user table
```

