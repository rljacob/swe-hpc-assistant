# Software Engineering Best Practices

Guidelines and patterns for code quality, review, testing, and workflow in HPC/scientific codebases.

## Format

Document what worked, what didn't, and the rationale behind conventions adopted.

---

## Code Review

None yet recorded.

## Testing Strategy

None yet recorded.

## Version Control Workflow

### [2026-10-22] Sync upstream into origin branch
- Created `sync-upstream-master` from the current `master`.
- Fetched both remotes, merged `upstream/master` with an explicit merge commit, and pushed the branch to `origin`.
- This preserves the existing `origin/master` while making the upstream sync available for review/PR.

## Documentation Conventions

None yet recorded.

## Build & CI

None yet recorded.

---

## Update History

### [2026-08-19] Initial Knowledge File
Created as part of swe-hpc-assistant scaffolding.

### [2026-11-18] Chrysalis F1850 build-only test
- On `chrysalis`, a build-only `SMS_Ld1.ne4pg2_oQU480.F1850.chrysalis_intel` test was created with `create_test --no-run`, Intel classic, and OpenMPI.
- CREATE_NEWCASE, XML, SETUP, SHAREDLIB_BUILD, and MODEL_BUILD passed; SUBMIT remains PEND by design.
- Case directory: `/lcrc/group/e3sm/jacob/scratch/chrys/SMS_Ld1.ne4pg2_oQU480.F1850.chrysalis_intel.goose_F1850_20261118`.
