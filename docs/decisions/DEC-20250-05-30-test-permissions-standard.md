# 🧠 Architectural Decision Record

**Title:** Enforce Executable Permissions on Setup Scripts  
**Status:** Accepted  
**Date:** 2025-05-30  
**Deciders:** PazzTech  
**Context:** PT: Workstation Setup

---

## 🎯 Decision

All shell scripts in the `scripts/` directory (and the top‐level `bootstrap` entrypoint) will be committed with the executable bit set. Tests and CI pipelines will invoke these scripts directly (e.g. `./scripts/setup-macos.sh --dry-run`), relying on their shebang lines rather than prefixing with `bash`.

---

## 🤔 Rationale

### Problems with the “bash-prefix” approach
- Masked missing execute permissions until test runtime  
- Inconsistent invocation patterns between bootstrap and smoke tests  
- Ignores the shebang mechanism, reducing portability  

### Benefits of enforcing exec-bit
- ✅ Aligns with Unix best practices and shebang semantics  
- 🛠️ Simplifies test/CI commands by allowing `./script.sh` invocation  
- 🔍 Surfaces permission errors at commit time rather than during test runs  
- 🔄 Ensures consistency across all platforms and contributors  

---

## ✍️ Structure Summary

Commit commands to set the exec bit in Git:

```bash
git update-index --add --chmod=+x bootstrap
git update-index --add --chmod=+x scripts/setup-macos.sh
.git update-index --add --chmod=+x tests/macos/smoke-engine-dev-env.sh

Invoke directly in tests:

./scripts/setup-macos.sh --dry-run


⸻

🔄 Alternatives Considered
	•	Prefix with bash: Hides missing exec-bit, bypasses shebang, and leads to inconsistent test patterns.
	•	CI auto-chmod before testing: Adds complexity and masks author errors.
	•	Rely on documentation only: Risks contributors forgetting to set the bit, leading to intermittent failures.

⸻

🔧 Implications
	•	Existing scripts must be updated in Git to include the executable bit.
	•	CI pipeline should include a lint step that verifies all *.sh files are executable.
	•	Contributors must remember to mark new scripts executable before committing.
	•	Documentation (e.g. README or CONTRIBUTING.md) must note this standard.

⸻

🔜 Next Steps
	•	Commit exec-bit changes for all current scripts.
	•	Implement a CI check for script executable permissions.
	•	Update smoke tests to remove any bash prefixes.
	•	Document this standard in the project’s CONTRIBUTING.md.

