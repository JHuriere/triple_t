---
mode: 'agent'
tools: ['changes', 'edit', 'problems', 'runCommands', 'search']
description: 'Generate, verify, refactor unit tests'
--- 

## Objective
Verify existing unit tests for `${selectedText}` function in ${file}. 
If tests are missing. Generate them following the rules below.
If tests already exist, verify their correctness and completeness with `${selectedText}`. Adapt the existing tests to adapt to the following rules if necessary.

## Rules
- Follow instructions from `.github/instructions/unit-testing.instructions.md`, these rules prevail over existing patterns in the codebase.
- If there is no `${selectedText}` function, just reply with "No function found". 