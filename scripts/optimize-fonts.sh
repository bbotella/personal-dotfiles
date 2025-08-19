#!/bin/bash

set -e

echo "🧹 Brewfile Optimization - Font Cleanup Script"
echo "=============================================="
echo

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get list of currently installed Nerd Fonts
echo "📊 Analyzing currently installed Nerd Fonts..."
INSTALLED_FONTS=$(brew list --cask | grep -E "font-.*-nerd-font" | sort)
FONT_COUNT=$(echo "$INSTALLED_FONTS" | wc -l | tr -d ' ')

echo -e "${YELLOW}Found $FONT_COUNT Nerd Fonts currently installed:${NC}"
echo "$INSTALLED_FONTS" | sed 's/^/  - /'
echo

# Show the curated list from optimized Brewfile
CURATED_FONTS=(
    "font-jetbrains-mono-nerd-font"
    "font-fira-code-nerd-font"
    "font-hack-nerd-font"
    "font-meslo-lg-nerd-font"
    "font-sauce-code-pro-nerd-font"
    "font-ubuntu-mono-nerd-font"
    "font-inconsolata-nerd-font"
    "font-monaspace-nerd-font"
)

echo -e "${GREEN}Curated list (8 essential fonts):${NC}"
for font in "${CURATED_FONTS[@]}"; do
    echo "  - $font"
done
echo

# Calculate space savings (approximate)
FONTS_TO_REMOVE=$(echo "$INSTALLED_FONTS" | grep -v -F "$(printf '%s\n' "${CURATED_FONTS[@]}")" | wc -l | tr -d ' ')
echo -e "${YELLOW}Fonts that can be removed: $FONTS_TO_REMOVE${NC}"
echo -e "${GREEN}Estimated space savings: ~$((FONTS_TO_REMOVE * 50))MB${NC}"
echo

# Ask user if they want to proceed
read -p "Would you like to remove the unused fonts? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🗑️  Removing unused Nerd Fonts..."
    
    # Remove fonts not in curated list
    for font in $INSTALLED_FONTS; do
        if [[ ! " ${CURATED_FONTS[@]} " =~ " ${font} " ]]; then
            echo "  Removing: $font"
            brew uninstall --cask "$font" 2>/dev/null || echo "    (already removed)"
        fi
    done
    
    echo -e "${GREEN}✅ Font cleanup completed!${NC}"
else
    echo "Skipping font cleanup."
fi

echo
echo "🔄 To install missing packages from the optimized Brewfile:"
echo "   brew bundle install --file=brew/Brewfile"
echo
echo "💡 To see what would be installed without actually installing:"
echo "   brew bundle check --file=brew/Brewfile --verbose"