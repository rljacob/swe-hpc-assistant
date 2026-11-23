# Lessons Learned

Insights, mistakes, corrections, and improvements discovered through interactions.

## Format

Document what worked, what didn't, and what was learned. Focus on actionable insights.

---

## Categories

### Performance Lessons
None yet recorded.

### Parallelism Lessons
None yet recorded.

### Language/Build Lessons

#### [2026-11-15] Flux-core build on chrlogin1 dependency gate
- The official Flux RHEL dependency script lists system packages including ZeroMQ, Jansson, LZ4, libarchive, hwloc, SQLite, Python development headers, cffi, and ply.
- On this user environment, system RPM development packages and Python cffi/ply are absent; the stock `autogen.sh` succeeds, but `configure` fails first while linking against the Spack Python 3.11 library.
- Do not run the upstream `yum install` script without root/admin approval; prefer an isolated Spack or user-prefix dependency stack under `/soft/climate` and explicitly set compiler/Python/pkg-config paths.


### Workflow Lessons
None yet recorded.

---

## Update History

### [2026-08-19] Initial Knowledge File
Created as part of swe-hpc-assistant scaffolding.

## [2026-11-22] MALI IG test on chrysalis_gnu: merge fix, MOAB-driver Zoltan clash

**Context:** Verifying a MALI merge on branch `next` (E3SM2) with `SMS*.ne30pg2_r05_IcoswISC30E3r5_gis4to40.IGELM_MLI.chrysalis_gnu.mali-landiceIG`.
**Key Information:**
- `.glcoff` etc. are case-dir suffixes (test-ids), not testmods; use `--test-id` for new instances.
- Build failure: merge left nested `if (nISMIP6OceanLayers>0)` / `if (importTF .or. importTFMask)` in `glc_import_mct` with one `endif` -> cascading gfortran "Expecting END IF" errors. Added `endif`.
- Default (MOAB driver) run segfaults in first Albany FO velocity solve: backtrace `Zoltan_Realloc <- Zoltan_LB_Partition <- velocity_solver_solve_fo_`. MOAB gnu build's bundled static Zoltan 3.901 preempts Trilinos 17.0.0 Zoltan used by Albany 2026.05.26. An older passing case had `-Wl,--exclude-libs,libzoltan.a` in chrysalis_gnu.cmake; not in current repo.
- MOAB `/lcrc/soft/climate/moab/chrysalis/gnu-develop-trilinos` is built against Trilinos 15.1.1/gcc 9.2.0 -> runtime `libzoltan.so.15 not found`; incompatible with Albany/Trilinos 17.
- `SMS_D_Vmct` (MCT driver) passes all phases.
- Don't `git add` conflicted files without asking (marks conflict resolved). Use $HOME not ~ in edit-tool paths.
**Follow-up:** Restore the exclude-libs workaround or get MOAB rebuilt against Trilinos 17.0.0/gcc 11.2.0.
