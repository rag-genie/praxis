Before running `git commit`, execute this checklist. Every item, no skipping. A commit that fails this gate creates downstream violations that compound.

1. **Enumerate all testable surfaces** created or modified in this commit:
   - New/changed functions in source directories → unit test required
   - New/changed database queries → integration test required
   - New/changed API routes → integration test required
   - New/changed user-facing surfaces (pages, endpoints, observable behavior) → e2e test required

2. **Verify test files exist for each surface:**
   - Find the actual test file path on disk — not assumed, not "will add later"
   - If missing, STOP and write it before committing
   - Config-assertion tests (reading files and asserting properties) count for non-runtime FRs

3. **Verify tasks.md is updated in this commit:**
   - Every implemented task must be marked `[x]` in the SAME commit as the code
   - If no task exists for this work, add one first (per pre-edit-gate step 3)

4. **Run all quality gates:**
   ```
   {{LINT_CMD}} && {{TYPECHECK_CMD}} && {{TEST_CMD}} && {{E2E_CMD}}
   ```
   All gates must pass. Not three of four.

   Examples by stack:
   - Node.js/TypeScript: `pnpm lint && pnpm typecheck && pnpm test && pnpm test:e2e`
   - Python: `ruff check . && mypy . && pytest && pytest tests/e2e/`
   - Rust: `cargo clippy && cargo test && cargo test --test e2e`
   - Go: `golangci-lint run && go test ./... && go test -tags=e2e ./...`

5. **Verify @spec tags and FR describe blocks:**
   - New source files with spec-governed behavior need traceability tags (e.g., `@spec NNN-FR-NNN` JSDoc tags, docstring references, or equivalent for your language)
   - New test describe blocks need FR ids in the description string
   - This enables traceability
