#!/bin/bash

# Define "./assets" variable
assets_dir="src/assets"

# Clear assets except pages.png
find "src/assets" -type f ! -name 'pages.png' -delete


# Function to download images referenced in the project README.md
download_images() {
    local readme_content="$1"
    local repo_url="$2"

    # Extract image URLs from the README content
    image_urls=$(echo "$readme_content" | grep -oE "!\[.*\]\((\.?/assets/[^\)]+)\)" | sed -n 's/.*(\.\?\(\/assets\/[^\)]\+\))/\1/p')

    # Download each image to the "./src/assets" directory if not already present
    for image_url in $image_urls; do
        local image_name=$(basename "$image_url")
        local destination="$assets_dir/$image_name"

        # Check if the image is in "./src/assets" directory
        if [ ! -f "$destination" ]; then
            curl -Ls "$repo_url/raw/main/$image_url" -o "$destination"
            echo "Downloaded $image_url to $destination"
        else
            echo "Image $image_url already exists in $assets_dir"
        fi
    done
}

# Loop through each md file in the src directory
for md_file in src/*.md; do
    # Check if the file contains the "Project Repo" line
    if grep -q "**Project Repo:**" "$md_file"; then
        # Extract the repo URL from the line
        repo_url=$(grep "**Project Repo:**" "$md_file" | sed 's/.*\[.*\](\(.*\))/\1/')

        # Download the README.md content from the repo URL
        readme_content=$(curl -Ls "$repo_url/raw/main/README.md")

        # Preserve the "Project Repo" line and replace all text after that
        sed -i '/\*\*Project Repo:\*\*/,$d' "$md_file"
        echo -e "**Project Repo:** [$repo_url]($repo_url)\n\n" >> "$md_file"
        
        # Download images referenced in the README.md to the "./src/assets" directory
        download_images "$readme_content" "$repo_url"

        # Append the README content to the md file
        echo "$readme_content" >> "$md_file"
        
        echo "Updated $md_file with README content from $repo_url"
    fi
done
