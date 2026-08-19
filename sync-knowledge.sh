#!/bin/bash
# Sync SWE/HPC assistant knowledge base and recipe

KB_DIR="$HOME/.config/goose/recipes/swe-hpc-assistant"
RECIPE_DIR="$HOME/.config/goose/recipes"

cd "$KB_DIR"

echo "SWE/HPC Assistant Knowledge Sync"
echo "===================================="

# Check if git repo exists
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial swe-hpc-assistant knowledge base"
    echo ""
    echo "Next steps:"
    echo "1. Create a private GitHub/GitLab repository"
    echo "2. Run: git remote add origin <your-repo-url>"
    echo "3. Run: git push -u origin main"
    exit 0
fi

# Commit any local changes
if [[ -n $(git status -s) ]]; then
    echo "Local changes detected, committing..."
    git add .
    git commit -m "Update knowledge base - $(date '+%Y-%m-%d %H:%M')"
fi

# Pull remote changes
echo "Pulling remote changes..."
git pull --rebase

# Push local changes
echo "Pushing local changes..."
git push origin main

# Copy recipe.yaml to parent directory so `goose run --recipe swe-hpc-assistant` can find it by name
echo "Updating recipe.yaml for name-based lookup..."
cp "$KB_DIR/recipe.yaml" "$RECIPE_DIR/swe-hpc-assistant.yaml"

echo ""
echo "✓ Sync complete!"
echo "Knowledge base is up to date on: $(git remote get-url origin 2>/dev/null || echo 'no remote configured')"
echo "Recipe available at: $RECIPE_DIR/swe-hpc-assistant.yaml"
