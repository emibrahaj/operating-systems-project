#!/bin/bash
# file_organizer.sh
# Organizes files into folders based on file extension.

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: '$TARGET_DIR' is not a directory."
  exit 1
fi

mkdir -p "$TARGET_DIR/Documents" "$TARGET_DIR/Images" "$TARGET_DIR/Source_Code" "$TARGET_DIR/Archives" "$TARGET_DIR/Other"

count=0

for file in "$TARGET_DIR"/*; do
  [ -f "$file" ] || continue

  filename=$(basename "$file")
  extension="${filename##*.}"

  case "$extension" in
    txt|pdf|doc|docx)
      mv "$file" "$TARGET_DIR/Documents/"
      ;;
    jpg|jpeg|png|gif)
      mv "$file" "$TARGET_DIR/Images/"
      ;;
    sh|py|java|c|cpp|js|html|css)
      mv "$file" "$TARGET_DIR/Source_Code/"
      ;;
    zip|tar|gz|rar)
      mv "$file" "$TARGET_DIR/Archives/"
      ;;
    *)
      mv "$file" "$TARGET_DIR/Other/"
      ;;
  esac

  count=$((count + 1))
done

echo "File organization complete."
echo "$count files moved."
