#!/bin/zsh

# Get latest Monaspace version
MONASPACE_VERSION=$(curl -s https://api.github.com/repos/githubnext/monaspace/releases/latest | jq -r .tag_name)

echo "Installing Monaspace version: $MONASPACE_VERSION"

# Define the destination directory
DEST_DIR="$HOME/.local/share/fonts"

# Create a temporary source directory
SOURCE_DIR="$HOME/monaspace_temp"
mkdir -p "$SOURCE_DIR"
cd "$SOURCE_DIR" || exit 1

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Install dependencies
sudo apt-get update
sudo apt install -y unzip

# Download fonts from Github
wget https://github.com/githubnext/monaspace/releases/download/$MONASPACE_VERSION/monaspace-frozen-$MONASPACE_VERSION.zip
wget https://github.com/githubnext/monaspace/releases/download/$MONASPACE_VERSION/monaspace-nerdfonts-$MONASPACE_VERSION.zip
wget https://github.com/githubnext/monaspace/releases/download/$MONASPACE_VERSION/monaspace-static-$MONASPACE_VERSION.zip
wget https://github.com/githubnext/monaspace/releases/download/$MONASPACE_VERSION/monaspace-variable-$MONASPACE_VERSION.zip

# Unzip downloaded files
unzip monaspace-frozen-$MONASPACE_VERSION.zip -d monaspace-frozen
unzip monaspace-nerdfonts-$MONASPACE_VERSION.zip -d monaspace-nerdfonts
unzip monaspace-static-$MONASPACE_VERSION.zip -d monaspace-static
unzip monaspace-variable-$MONASPACE_VERSION.zip -d monaspace-variable

# Counter for moved files
count=0

# Font file extensions to search for
font_extensions=("*.ttf" "*.otf" "*.TTF" "*.OTF" "*.woff" "*.woff2" "*.eot")

echo "Searching for font files in: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo "----------------------------------------"

# Iterate through each font extension
for ext in "${font_extensions[@]}"; do
    # Find all files with current extension
    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo "Moving: $file"
            mv "$file" "$DEST_DIR/"
            ((count++))
        fi
    done < <(find "$SOURCE_DIR" -type f -iname "$ext" -print0)
done

echo "----------------------------------------"
echo "Total files moved: $count"

# Update font cache if fc-cache is available
if command -v fc-cache &> /dev/null; then
    echo "Updating font cache..."
    fc-cache -f -v "$DEST_DIR"
    echo "Font cache updated!"
else
    echo "fc-cache not found. You may need to update the font cache manually."
fi

echo "Done!"

cd - || exit 1

# Clean up temporary source directory
rm -rf "$SOURCE_DIR"