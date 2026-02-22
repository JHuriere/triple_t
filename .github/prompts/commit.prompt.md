---
mode: 'agent'
tools: ['changes', 'problems', 'runCommands', 'search']
description: 'Create commits'
--- 

## Objective
Add and commit the changes made since the last commit with a message that follows the following rules.

## Rules
- Follow instructions from `.github/instructions/conventional-commit.instructions.md`.
- Analyze changed files to determine appropriate commit type and scope.
- If it makes sense, split the changes into multiple commits.
- Ensure commit messages are clear, concise, and follow the Conventional Commits format.
- Split related changes into logical commits when appropriate.
- Wait for hooks to validate the commit before finalizing. If there are any issues, address them before completing the commit. In this case, wait for user to validate the changes before proceeding.
- Verify you are committing undesired changes (such as debug code, console log, weird comments,  etc.). In this case, wait for user to validate the changes before proceeding.
- Do not push the commits. 
- Return a concise summary of the commits made (message and files associated) after all commits are done.