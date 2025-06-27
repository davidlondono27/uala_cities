# Define the folders to exclude
exclude_folders=(
    "./DerivedData"
    "./SourcePackages"
    "./uala_citiesTests"
    "./uala_cities.xcodeproj"
    "./.git"
    "./.github"
    "./build"
    "./fastlane"
)

# Find all files named "Localizable.strings" recursively
file_paths=($(find . -type f -name "Localizable.strings"))

# Exclude specified folders from the list
filtered_paths=()
for path in "${file_paths[@]}"; do
    exclude=false
    for folder in "${exclude_folders[@]}"; do
        if [[ "$path" == *"$folder"* ]]; then
            exclude=true
            break
        fi
    done
    [ "$exclude" == false ] && filtered_paths+=("$path")
done

# Loop through the array of filtered file paths
for file_path in "${filtered_paths[@]}"; do
    # Use sort to alphabetize the lines and overwrite the original file
    sort -u "$file_path" -o "$file_path"
    
    if [ $? -eq 0 ]; then
        # Sorting and removing duplicates successful
        echo "success: File $file_path alphabetized successfully."
    else
        # Sorting and removing duplicates failed
        echo "warning: File not found: $file_path"
    fi
done
