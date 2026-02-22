---
applyTo: "*"
---

# Conventional Commit Guidelines

Generate a commit message following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format.

## Commit Format

- Use one of the following types: feat, fix, chore, docs, refactor, test, perf, ci, build
- Format: <type>(<scope>): <short description>
- Scope is optional but recommended. A scope MUST consist of a noun describing a section of the codebase surrounded by parenthesis
- Provide a short, clear summary
- Avoid generic messages like 'fix bug'
- If relevant, add a longer description in a new paragraph

## Commit Type to SemVer Mapping

- `feat`: MINOR version increment (or MAJOR if breaking change is indicated)
- `fix`: PATCH version increment
- Add `BREAKING CHANGE:` in commit message body to indicate MAJOR version increment (or use `!` after type/scope)
- Example for breaking change:
  ```
  feat(api): remove user endpoint

  BREAKING CHANGE: The user endpoint has been removed and replaced with profile endpoint
  ```
