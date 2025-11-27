#!/bin/bash

# Security Check Script
# Run this before committing to detect secrets and vulnerabilities

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Security Check - Blog Repository${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if Trivy is installed
if ! command -v trivy &> /dev/null; then
    echo -e "${YELLOW}⚠️  Trivy is not installed${NC}"
    echo ""
    echo "Install Trivy:"
    echo "  macOS:   brew install aquasecurity/trivy/trivy"
    echo "  Linux:   https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    echo ""
    exit 1
fi

echo -e "${BLUE}[1/4] Checking for secrets...${NC}"
echo ""

# Scan for secrets
if trivy fs --scanners secret --severity CRITICAL,HIGH . 2>&1 | grep -q "Total: 0"; then
    echo -e "${GREEN}✅ No secrets detected${NC}"
else
    echo -e "${RED}❌ SECRETS DETECTED!${NC}"
    echo ""
    trivy fs --scanners secret --severity CRITICAL,HIGH .
    echo ""
    echo -e "${RED}Please remove secrets before committing!${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[2/4] Scanning for vulnerabilities...${NC}"
echo ""

# Scan for vulnerabilities
trivy fs --severity CRITICAL,HIGH --quiet .

echo ""
echo -e "${BLUE}[3/4] Checking for sensitive files...${NC}"
echo ""

# List of patterns to check
SENSITIVE_PATTERNS=(
    "*.pem"
    "*.key"
    "*.p12"
    "*.pfx"
    "*id_rsa*"
    "*id_dsa*"
    "*id_ecdsa*"
    "*.env"
    ".env.*"
    "*credentials*"
    "*secret*"
    "*password*"
    "*.kdb"
    "*.asc"
    "*.ovpn"
)

FOUND_SENSITIVE=0

for pattern in "${SENSITIVE_PATTERNS[@]}"; do
    files=$(git ls-files | grep -i "$pattern" || true)
    if [ ! -z "$files" ]; then
        if [ $FOUND_SENSITIVE -eq 0 ]; then
            echo -e "${YELLOW}⚠️  Found potentially sensitive files:${NC}"
            FOUND_SENSITIVE=1
        fi
        echo "  - $files"
    fi
done

if [ $FOUND_SENSITIVE -eq 0 ]; then
    echo -e "${GREEN}✅ No sensitive files detected${NC}"
else
    echo ""
    echo -e "${YELLOW}Please review these files before committing${NC}"
fi

echo ""
echo -e "${BLUE}[4/4] Checking .gitignore coverage...${NC}"
echo ""

# Check if common sensitive patterns are in .gitignore
GITIGNORE_PATTERNS=(
    "*.pem"
    "*.key"
    ".env"
    "*credentials*"
)

MISSING_PATTERNS=()

for pattern in "${GITIGNORE_PATTERNS[@]}"; do
    if ! grep -q "$pattern" .gitignore 2>/dev/null; then
        MISSING_PATTERNS+=("$pattern")
    fi
done

if [ ${#MISSING_PATTERNS[@]} -eq 0 ]; then
    echo -e "${GREEN}✅ .gitignore has good coverage${NC}"
else
    echo -e "${YELLOW}⚠️  Consider adding to .gitignore:${NC}"
    for pattern in "${MISSING_PATTERNS[@]}"; do
        echo "  - $pattern"
    done
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ Security check complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${BLUE}Summary:${NC}"
echo "  • No secrets detected"
echo "  • Vulnerability scan complete"
echo "  • Ready to commit"
echo ""
