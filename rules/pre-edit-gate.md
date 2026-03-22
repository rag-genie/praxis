Before modifying ANY source file, answer these four questions. Do not skip this for "small" changes — classification is by governance scope, not perceived effort.

1. **What spec governs this area?** Check `specs/` for the spec whose scope covers the file. If none exists and it's not a lightweight exception, create one.
2. **Does the spec reflect the intended change?** If not, update the spec FIRST. Code must not advance beyond what the spec describes.
3. **Does tasks.md have a task for this work?** If not, add one before implementing.
4. **Only then: implement.** Write code and tests, mark the task `[x]` in the same commit.

Lightweight exceptions (config values, bug fixes where spec already describes correct behavior, dependency updates) skip the full cycle but still need a conventional commit and regression test.
