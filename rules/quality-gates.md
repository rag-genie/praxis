**Process over speed.** A correct process that delivers slowly beats a fast process that delivers incorrectly.

**Review posture: "try to break this."** Actively search for contradictions, missing coverage, stale references. A review that finds nothing should provoke skepticism, not satisfaction.

**Reviews require 2 consecutive clean passes.** Explicitly list rounds: "Round N: clean. Round M: clean. Count: 2 of 2." Never declare without listing specific rounds.

**Three-layer review before merge:**
1. Constitution → Spec (2 clean passes)
2. Spec → Code (2 clean passes)
3. Pre-commit gate (lint, typecheck, test, e2e)

If layer 3 finds issues, root-cause which earlier layer missed them before proceeding.

**Context integrity.** Do not delegate context-dependent tasks (cross-artifact reviews, compliance verification, deferral validation) to sub-agents that lack the conversation context. Delegation is appropriate only for bounded, self-contained queries.
