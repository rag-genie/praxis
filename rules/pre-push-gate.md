Before running `git push`, execute this checklist. Push and PR description update are ATOMIC — never push without updating the description.

1. **Verify the branch is not a reused post-merge branch:**
   - If this branch was previously squash-merged to main, STOP. Create a new branch from main instead.

2. **Draft the PR description BEFORE pushing:**
   - If a PR already exists: draft the updated `gh pr edit` body now
   - If no PR exists yet: draft the `gh pr create` body now
   - The PR description is the source of truth for the squash commit message

3. **Execute push and PR update together:**
   - Run `git push`
   - Immediately run `gh pr edit` (or `gh pr create`) with the drafted description
   - These two commands are a single atomic operation — never defer the PR update

4. **Verify the PR description matches the branch state:**
   - Description must reflect ALL commits on the branch, not just the latest
   - Never include content that hasn't been pushed
   - Never update a merged PR's description with unmerged content
