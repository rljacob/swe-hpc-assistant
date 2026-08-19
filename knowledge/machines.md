# HPC Machine Information

Machine-specific compiler, toolchain, scheduler, and performance details relevant to software engineering and HPC work.

> **Note:** This file currently duplicates the intent of `scientific-assistant/knowledge/machines.md`. Whether these two files should be merged/shared or kept independent is an open decision - see the "Sharing with scientific-assistant" section below. Until decided, keep this file focused on SWE/HPC-programming details (compilers, flags, schedulers, profilers) while `scientific-assistant`'s copy focuses on E3SM-specific paths and run configuration.

## Format

Document machine-specific details to help with cross-machine development and performance work.

---

## Machines

### Local Development Machine

**Hostname:** (to be recorded on first use)

**Purpose:**
- Code development
- Local builds/tests
- Profiling analysis (post-processing)

**Notes:**
- Use for code editing, small-scale builds, and static analysis
- Transfer to HPC for actual performance runs

---

### HPC Machines

#### [Machine Name - To Be Added]

**Hostname:**

**Account/Project:**

**Compiler Toolchain:**
- Compilers available (e.g., Intel, GNU, Cray, NVHPC):
- Default/recommended compiler + version:
- Key optimization flags used:

**MPI Implementation:**
- Implementation (e.g., Cray MPICH, OpenMPI, MVAPICH):
- Version:
- Launch command (e.g., srun, aprun, mpirun):

**Batch System:**
- Type: (SLURM, PBS, etc.)
- Typical wait times:
- Node/core layout (cores per node, NUMA domains, GPUs per node):

**Profiling/Debugging Tools Available:**
- Profilers (e.g., perf, VTune, TAU, HPCToolkit, nsight):
- Debuggers (e.g., DDT, TotalView, gdb, cuda-gdb):

**File Locations:**
- Build/scratch space:
- Shared/persistent storage:

**Quirks/Notes:**
- Special module requirements:
- Known compiler bugs or workarounds:
- Performance tips:

---

## Sharing with scientific-assistant

Both `swe-hpc-assistant` and `scientific-assistant` care about HPC machine facts (compilers, schedulers, module systems), but from different angles (engineering/performance vs. E3SM run configuration). Options considered:

1. **Keep separate** (current default) - each recipe records only what's relevant to its domain; some duplication of basic facts (hostname, scheduler type) is acceptable.
2. **Shared file** - move machine facts to a common location (e.g. `~/.config/goose/knowledge/machines.md`) that both recipes read/update.

**Status:** Not yet decided - pending user input.

---

## Update History

### [2026-08-19] Initial Machine Knowledge File
Created as part of swe-hpc-assistant scaffolding.
