# SWE/HPC Assistant - Software Engineering & High-Performance Computing

A learning software engineering assistant specialized in HPC programming: SWE best practices, performance tuning, Fortran & C++, and MPI parallelism.

## Description

This recipe provides a persistent, learning assistant for software engineering and HPC development work. The assistant maintains a knowledge base that grows over time, helping with code design, performance tuning, parallel programming, and engineering best practices.

It is intentionally **separate** from the `scientific-assistant` recipe, which owns climate-science/E3SM domain knowledge (experiment planning, compsets, climate concepts). This assistant owns software-engineering and HPC-programming knowledge instead. Use whichever recipe matches the task at hand; the two can be used side by side.

## Features

- **Performance Tuning**: Diagnoses bottlenecks and documents optimization strategies and measured impact
- **Fortran & C++ Expertise**: Language idioms, interoperability, and build-system guidance
- **MPI Parallelism**: Domain decomposition, communication patterns, hybrid parallelism, and debugging guidance
- **Continuous Learning**: Updates knowledge base after each interaction
- **Context Awareness**: References past optimizations, decisions, and preferences
- **Structured Knowledge**: Maintains organized markdown files for different knowledge domains

## Knowledge Base

Located at `~/.config/goose/recipes/swe-hpc-assistant/knowledge/`:

- **swe_best_practices.md**: Code review, testing, version control, documentation, and build/CI conventions
- **performance_tuning.md**: Performance issues diagnosed, optimizations applied, and measured impact
- **fortran_cpp.md**: Fortran and C++ language knowledge, interoperability patterns, and build systems
- **mpi_parallelism.md**: Domain decomposition, communication patterns, hybrid parallelism, and debugging notes
- **user_preferences.md**: Coding style, tooling, and workflow preferences
- **lessons_learned.md**: Insights from past interactions
- **index.md**: Cross-references and quick lookup

In addition, HPC machine information is kept in a **shared** file used by both this recipe and `scientific-assistant`, at `~/.config/goose/shared-knowledge/machines.md` (see the [shared-knowledge README](../../shared-knowledge/README.md)). This assistant does not keep its own `machines.md`.

## Setup

For detailed setup instructions including GitHub sync and HPC installation, see **[SETUP.md](SETUP.md)**.

**Quick setup:**
```bash
# On local machine - initialize git and push to GitHub
cd ~/.config/goose/recipes/swe-hpc-assistant
./sync-knowledge.sh

# On HPC machine - clone and install goose
pip install --user goose-ai
mkdir -p ~/.config/goose/recipes
cd ~/.config/goose/recipes
git clone git@github.com:YOUR_USERNAME/swe-hpc-assistant.git
```

## Usage

## Recipe File Format

This recipe includes:

1. **recipe.yaml** (YAML format - required for `goose run --recipe`)
2. **recipe.md** (Markdown reference copy - not directly loadable by the CLI)

The CLI loads `recipe.yaml` (or the `swe-hpc-assistant.yaml` copy in the parent recipes directory). `recipe.md` is kept as a human-readable copy of the same content.

### Start the Assistant

```bash
goose run --recipe swe-hpc-assistant
```

> **Note:** `goose session` does not currently support a `--recipe` flag. Use `goose run --recipe swe-hpc-assistant` on all machines. If you want to keep chatting after the recipe's initial prompt runs, add `--interactive` (or `-s`): `goose run --recipe swe-hpc-assistant --interactive`.

### Sync Across Machines

```bash
# Before and after work on any machine
cd ~/.config/goose/recipes/swe-hpc-assistant
./sync-knowledge.sh
```

### Example Interactions

**Diagnosing performance:**
```
User: My MPI halo exchange is scaling poorly past 512 ranks
Assistant: [Loads mpi_parallelism.md and performance_tuning.md]
          Suggests likely causes and diagnostic steps
          Documents the diagnosis and fix in knowledge base
```

**Learning a preference:**
```
User: I always want Fortran code formatted with fprettify using our .fprettify.rc
Assistant: [Updates user_preferences.md]
          Applies this convention in future Fortran work
```

**Referencing past work:**
```
User: What did we find when we profiled the radiation kernel before?
Assistant: [Searches performance_tuning.md]
          Provides past diagnosis, fix, and measured impact
```

## How It Learns

The assistant updates its knowledge base after significant interactions by:

1. **Extracting new information** from the conversation
2. **Categorizing** into appropriate knowledge files
3. **Structuring** with dates and context
4. **Cross-referencing** related concepts
5. **Reflecting** on what worked well

## Workflow

### Session Start
1. Loads relevant knowledge based on context
2. References past decisions/optimizations if applicable
3. Ready to assist with current task

### During Interaction
1. Provides expertise from both training and knowledge base
2. Suggests approaches based on past successes
3. Asks clarifying questions when needed (target machine, scale, language standard)

### Session End
1. Updates knowledge files with new information
2. Documents optimizations, preferences, or insights
3. Cross-references related knowledge

## Knowledge Update Guidelines

Updates are made when:
- Diagnosing or fixing a performance issue
- Discussing Fortran/C++ language or build-system specifics
- Designing or debugging an MPI communication pattern
- User expresses a coding style or tooling preference
- Learning from a mistake or clarification
- Establishing a review/testing/workflow convention

## Relationship to scientific-assistant

- Machine-specific facts (compilers, schedulers, module systems) are shared via `~/.config/goose/shared-knowledge/machines.md`, used and updated by both recipes.
- If a task spans both domains (e.g., performance-tuning an E3SM component), it's fine to note that `scientific-assistant` may have relevant experiment context, but this assistant will not read or modify that recipe's recipe-specific knowledge base directly.

## Customization

Edit the recipe file to customize:
- Knowledge file structure
- Update frequency
- Communication style
- Domain focus areas

## Requirements

- Goose developer extension (for shell, file operations)
- Access to relevant HPC/software codebases
- Supported HPC machine (for performance/parallel work)

## Tips

- Be explicit about preferences to help the assistant learn
- Reference past optimizations or issues by date or name
- Ask the assistant to explain its reasoning
- Provide feedback on suggestions to improve future recommendations

## Maintenance

Periodically (every 1-2 months):
- Review knowledge files for outdated information
- Consolidate related entries
- Archive resolved/stale issues
- Update machine details as toolchains change

## Version

1.0.0 - Initial release (2026-08-19)

## Author

Created for software engineering and HPC development work
