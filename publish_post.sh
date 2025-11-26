#!/bin/bash

# Octopress Blog Post Publisher
# Usage: ./publish_post.sh "Post Title" "Category1,Category2,Category3"

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if title is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Post title is required${NC}"
    echo "Usage: ./publish_post.sh \"Post Title\" \"Category1,Category2,Category3\""
    exit 1
fi

POST_TITLE="$1"
CATEGORIES="${2:-DevOps,Tutorial}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Octopress Blog Post Publisher${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Step 1: Create new post
echo -e "${YELLOW}[1/6] Creating new post...${NC}"
bundle exec rake new_post["$POST_TITLE"]

# Find the most recently created post file
POST_FILE=$(ls -t source/_posts/*.markdown | head -1)
echo -e "${GREEN}✓ Post created: $POST_FILE${NC}"

# Step 2: Add categories to the post
echo -e "${YELLOW}[2/6] Adding categories...${NC}"
if [ -n "$CATEGORIES" ]; then
    # Convert comma-separated string to array format
    IFS=',' read -ra CAT_ARRAY <<< "$CATEGORIES"
    CAT_STRING="["
    for i in "${!CAT_ARRAY[@]}"; do
        if [ $i -gt 0 ]; then
            CAT_STRING+=", "
        fi
        CAT_STRING+="${CAT_ARRAY[$i]}"
    done
    CAT_STRING+="]"

    # Add categories line after the date line
    sed -i '' "/^date:/a\\
categories: $CAT_STRING
" "$POST_FILE"
    echo -e "${GREEN}✓ Categories added: $CAT_STRING${NC}"
fi

# Step 3: Open the post in default editor
echo -e "${YELLOW}[3/6] Opening post in editor...${NC}"
echo -e "${BLUE}Please edit your post and save when done.${NC}"
echo -e "${BLUE}Press Enter when you're ready to continue...${NC}"

# Detect editor
if [ -n "$EDITOR" ]; then
    $EDITOR "$POST_FILE"
elif command -v code &> /dev/null; then
    code --wait "$POST_FILE"
elif command -v vim &> /dev/null; then
    vim "$POST_FILE"
else
    open "$POST_FILE"
fi

read -p ""

# Step 4: Generate site
echo -e "${YELLOW}[4/6] Generating site...${NC}"
bundle exec rake generate
echo -e "${GREEN}✓ Site generated${NC}"

# Step 5: Deploy
echo -e "${YELLOW}[5/6] Deploying to GitHub Pages...${NC}"
bundle exec rake deploy
echo -e "${GREEN}✓ Deployed to main branch${NC}"

# Step 6: Commit source
echo -e "${YELLOW}[6/6] Committing source files...${NC}"
git add .
git commit -m "Add new post: $POST_TITLE

🤖 Generated with publish_post.sh script

Co-Authored-By: Claude <noreply@anthropic.com>"
git push origin source
echo -e "${GREEN}✓ Source committed and pushed${NC}"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✓ Post published successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${BLUE}Your post will be available at:${NC}"
echo -e "${BLUE}https://rodrigodlima.github.io${NC}"
echo ""
