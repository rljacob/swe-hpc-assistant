# Cross-Machine Setup Guide

This guide helps you use the SWE/HPC Assistant on both local and HPC machines with GitHub sync.

## Prerequisites

- GitHub account
- SSH access to your HPC machine
- Git configured on both machines

## Setup Steps

### 1. Initialize Git Repository (Local Machine)

```bash
cd ~/.config/goose/recipes/swe-hpc-assistant

# Initialize and make first commit
git init
git add .
git commit -m "Initial swe-hpc-assistant knowledge base"
```

### 2. Create GitHub Repository

**Option A: Via GitHub Web Interface**
1. Go to https://github.com/new
2. Create a **private** repository (recommended for research/engineering notes)
3. Name it: `swe-hpc-assistant` (or your preferred name)
4. Don't initialize with README (we already have files)
5. Copy the repository URL

**Option B: Via GitHub CLI** (if you have `gh` installed)
```bash
cd ~/.config/goose/recipes/swe-hpc-assistant
gh repo create swe-hpc-assistant --private --source=. --push
```

### 3. Connect Local Repository to GitHub

```bash
cd ~/.config/goose/recipes/swe-hpc-assistant

# Add remote (replace with your GitHub username)
git remote add origin git@github.com:YOUR_USERNAME/swe-hpc-assistant.git

# Or use HTTPS if you prefer:
# git remote add origin https://github.com/YOUR_USERNAME/swe-hpc-assistant.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### 4. Install Goose on HPC

SSH into your HPC machine and follow these steps:

```bash
# Load Python module (adjust for your HPC)
module load python3  # or: module load anaconda3

# Install Goose
pip install --user goose-ai

# Or in a conda/virtual environment (recommended):
conda create -n goose python=3.10
conda activate goose
pip install goose-ai

# Verify installation
goose --version
```

**Add to your HPC `.bashrc` or `.bash_profile`:**
```bash
# For pip --user install
export PATH="$HOME/.local/bin:$PATH"

# For conda environment
# conda activate goose  # Uncomment if using conda
```

### 5. Clone Knowledge Base on HPC

```bash
# On HPC machine
mkdir -p ~/.config/goose/recipes
cd ~/.config/goose/recipes

# Clone your repository
git clone git@github.com:YOUR_USERNAME/swe-hpc-assistant.git
# Or with HTTPS:
# git clone https://github.com/YOUR_USERNAME/swe-hpc-assistant.git

# Make sync script executable
cd swe-hpc-assistant
chmod +x sync-knowledge.sh
```

### 6. Configure Git on HPC (if needed)

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set up SSH key for GitHub (if using SSH)
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy this and add to GitHub: https://github.com/settings/keys
```

## Daily Workflow

### On Local Machine

```bash
# Before starting work - get latest from HPC
cd ~/.config/goose/recipes/swe-hpc-assistant
./sync-knowledge.sh

# Work with the assistant
goose run --recipe swe-hpc-assistant

# After a coding/performance session - sync to GitHub
./sync-knowledge.sh
```

### On HPC Machine

```bash
# Before working - get latest from local
cd ~/.config/goose/recipes/swe-hpc-assistant
./sync-knowledge.sh

# Use the assistant
goose run --recipe swe-hpc-assistant

# Or build/profile/run your code directly

# After a session - update knowledge and sync
./sync-knowledge.sh
```

> **Note:** Use `goose run --recipe swe-hpc-assistant` on all machines. Add `--interactive` if you want to keep chatting after the initial recipe prompt runs (e.g. `goose run --recipe swe-hpc-assistant --interactive`).

## Sync Script Usage

The `sync-knowledge.sh` script automatically:
1. Commits any local changes with timestamp
2. Pulls remote changes (from other machine)
3. Pushes local changes to GitHub
4. Handles merge conflicts gracefully

```bash
cd ~/.config/goose/recipes/swe-hpc-assistant
./sync-knowledge.sh
```

## Best Practices

### 1. Sync Often
- **Before** starting work on either machine
- **After** completing a performance-tuning or debugging session
- **Daily** if actively using both machines

### 2. Use Descriptive Commits
If you prefer manual commits over the script:
```bash
git add .
git commit -m "Documented MPI halo exchange scaling fix"
git push
```

### 3. Handle Conflicts
If both machines edit the same file:
```bash
# Pull first
git pull

# If conflicts occur, edit the conflicted files
# Look for <<<<<<< HEAD markers
vim knowledge/performance_tuning.md

# After resolving
git add .
git commit -m "Resolved sync conflicts"
git push
```

### 4. Keep Recipe Updated
When Goose updates or you want to refine the assistant's behavior:
```bash
# Edit recipe.yaml (and mirror changes into recipe.md) with improvements
vim recipe.yaml
git add recipe.yaml recipe.md
git commit -m "Updated recipe with new guidance"
git push
```

## Troubleshooting

### Can't Push to GitHub
```bash
# Check remote URL
git remote -v

# If using HTTPS, you may need a personal access token
# Generate at: https://github.com/settings/tokens

# Or switch to SSH
git remote set-url origin git@github.com:YOUR_USERNAME/swe-hpc-assistant.git
```

### Merge Conflicts
```bash
# See what changed
git status
git diff

# Accept their version
git checkout --theirs path/to/file

# Accept our version
git checkout --ours path/to/file

# After resolving
git add .
git commit
```

### HPC Module Issues
Some HPCs have specific requirements:
```bash
# Load required modules (check HPC docs)
module load git
module load python/3.10
module load gcc  # May be needed for some Python packages

# List available modules
module avail python
module avail git
```

### Goose Not Found on HPC
```bash
# Check if in PATH
which goose

# If installed with --user, add to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Or use full path
~/.local/bin/goose --version
```

## Advanced: Automatic Sync

### Cron Job (HPC)
To automatically sync after each session:
```bash
# Edit crontab
crontab -e

# Add line to sync every hour
0 * * * * cd ~/.config/goose/recipes/swe-hpc-assistant && ./sync-knowledge.sh >> ~/sync.log 2>&1
```

### Git Hooks
To sync automatically after commits:
```bash
cd ~/.config/goose/recipes/swe-hpc-assistant/.git/hooks

# Create post-commit hook
cat > post-commit << 'EOF'
#!/bin/bash
git push
EOF

chmod +x post-commit
```

## Security Note

Since this contains engineering notes and possibly proprietary code details:
- ✅ Use a **private** GitHub repository
- ✅ Keep sensitive data (passwords, API keys, proprietary code) out of the knowledge base
- ✅ Consider institutional policies about cloud storage
- ✅ Use SSH keys instead of password authentication

## Quick Reference

```bash
# Setup (one-time per machine)
git clone git@github.com:USERNAME/swe-hpc-assistant.git
cd swe-hpc-assistant && chmod +x sync-knowledge.sh

# Daily workflow
./sync-knowledge.sh                          # Before work
goose run --recipe swe-hpc-assistant         # Do work
./sync-knowledge.sh                          # After work

# Check status
git status          # See what changed
git log --oneline   # See recent history
git diff            # See detailed changes
```

## Support

If you encounter issues:
1. Check GitHub repository permissions
2. Verify SSH key setup: `ssh -T git@github.com`
3. Test git operations manually before using script
4. Review HPC documentation for module loading
5. Check Goose installation: `goose --version`

## Goose Recipe Command

`goose session` does not support a `--recipe` flag. Loading this recipe (on any machine, any goose version) is done with:

```bash
goose run --recipe swe-hpc-assistant
```

This runs the recipe's initial prompt and exits. To keep chatting afterward, add `--interactive` (or `-s`):

```bash
goose run --recipe swe-hpc-assistant --interactive
```

`goose run --recipe` loads `recipe.yaml` (YAML format). `recipe.md` is kept only as a human-readable copy of the same instructions and is not loaded directly by the CLI.

### Check Your Version

```bash
goose --version
```

---

## IMPORTANT: Recipe File Location for `goose run --recipe <name>`

### The Problem

When you load a recipe by name (e.g. `goose run --recipe swe-hpc-assistant`), goose looks for `swe-hpc-assistant.yaml` or `swe-hpc-assistant.json` directly inside a recipes directory (current directory, `GOOSE_RECIPE_PATH`, or `~/.config/goose/recipes/`):
```
~/.config/goose/recipes/swe-hpc-assistant.yaml
```

NOT inside a subdirectory:
```
~/.config/goose/recipes/swe-hpc-assistant/recipe.yaml  ❌ Not found by name lookup
```

This is standard goose recipe-by-name behavior (confirmed on goose 1.44.0).

### The Solution

**On any machine (one-time setup after cloning):**

```bash
cd ~/.config/goose/recipes
cp swe-hpc-assistant/recipe.yaml swe-hpc-assistant.yaml

# Verify it was created
ls -la swe-hpc-assistant.yaml

# Now test - should work!
goose run --recipe swe-hpc-assistant
```

### Final Directory Structure

```
~/.config/goose/recipes/
├── swe-hpc-assistant.yaml              ← Flat copy goose finds by name ✅
└── swe-hpc-assistant/                  ← Knowledge base + git repo
    ├── recipe.yaml                     ← Canonical recipe (same content as above)
    ├── recipe.md                       ← Human-readable copy (not loaded by CLI)
    ├── knowledge/                      ← All knowledge files
    │   ├── swe_best_practices.md
    │   ├── performance_tuning.md
    │   ├── fortran_cpp.md
    │   ├── mpi_parallelism.md
    │   └── ...
    ├── sync-knowledge.sh
    └── README.md
```

### Why This Structure?

- **Knowledge base**: Organized in subdirectory with git
- **Recipe file**: Copied to parent directory so `goose run --recipe swe-hpc-assistant` can find it by name
- **Sync script**: Automatically maintains both copies (local only)
- **New machine**: Needs the flat copy created once after initial clone

### After Initial Setup

On local machine, the `sync-knowledge.sh` script automatically maintains both locations.

On other machines, you only need to copy the recipe file ONCE during initial setup. After that, just use `git pull` to update the knowledge base, and re-copy `recipe.yaml` to the parent directory if it changes.
