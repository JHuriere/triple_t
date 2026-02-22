---

mode: 'agent'
tools: ['changes', 'problems', 'runCommands', 'search']
description: 'Packages update agent'
---

## Objective
Update project dependencies to their latest versions and commit the changes.

Generate a concise summary of the important updates made. If there is interesting changes in the updated packages, mention them in the summary.

## Rules
- Create a new branch names `git checkout -b fix/update-dependencies-YY-MM-DD`, change `YY-MM-DD` to today's date
- Fetch latest dependency versions.
- Based on the fetched versions, manually update version by starting with packages with PATCH updates, then MINOR, and finally MAJOR updates.
- For each level (PATCH, MINOR, MAJOR), update all packages that can be updated at that level.
- After updating packages at each level, run tests (`flutter run test`) and the app build (`flutter run build`) to ensure nothing is broken. If there are issues, fix them before proceeding to commit.
- Only commit if tests and build pass.
- Do one commit for each level (MAJOR, MINOR, PATCH) with message `fix: update packages - ${LEVEL}`.
- Push the branch to remote with `git push --set-upstream origin fix/update-dependencies-YY-MM-DD`.
- If you encounter complexe issues (like conflicts between packages, or changes that require significant code modifications), skip them and mention them in the summary.
