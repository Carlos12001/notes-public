#!/bin/bash

# Publish (publish)
# Copy the notes vault into this repository and push it, so what is written
# on any device ends up on the site

publish() {
  local command="${1:-publish}"
  local repo_dir
  repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local vault_dir="${PUBLISH_VAULT_DIR:-$HOME/Documents/Synced/Notes}"
  local target_dir="$repo_dir/src"

  # Never published: the Private folder, the README of the vault and of each
  # folder, note templates and what Obsidian keeps for itself. The vault's
  # agent file is copied, so an agent reading the repository has the rules
  # of the notes. The home page of the site exists only in the repository,
  # so it is left alone.
  local excludes=(
    --exclude='/Private/'
    --exclude='README.md'
    --exclude='/Templates/'
    --exclude='.obsidian/'
    --exclude='.trash/'
    --exclude='*.conflict*'
    --exclude='/index.md'
  )

  # Mirror the notes by content: a note removed or renamed in the vault
  # changes here too. Two things are taken: Markdown notes, and whatever sits
  # in a folder named `attachments`, which is where Obsidian puts the images
  # and files a note embeds. Books in Reading/ are neither, so they stay out.
  local copy_opts=(-rc --delete --prune-empty-dirs "${excludes[@]}"
    --exclude='/Reading/' --include='*/' --include='*.md'
    --include='attachments/**' --exclude='*')

  if [[ "$command" == "publish" || "$command" == "status" ]]; then
    if [[ ! -d "$vault_dir" ]]; then
      echo -e "\033[31mError: notes folder not found: $vault_dir\033[0m"
      return 1
    fi
  fi

  case "$command" in
  "publish")
    echo -e "\033[32mCopying notes: vault -> repository...\033[0m"
    mkdir -p "$target_dir"
    rsync "${copy_opts[@]}" --info=name1 "$vault_dir/" "$target_dir/" ||
      return 1

    git -C "$repo_dir" add -- src
    if git -C "$repo_dir" diff --cached --quiet; then
      echo -e "\033[32mNothing new to publish.\033[0m"
      return 0
    fi

    echo -e "\033[32mPublishing...\033[0m"
    git -C "$repo_dir" commit -q -m "docs: update the notes" &&
      git -C "$repo_dir" push -q &&
      echo -e "\033[32mPublished. The site updates in a few minutes.\033[0m"
    ;;
  "status")
    echo -e "\033[33mNotes that differ (nothing is copied)...\033[0m"
    rsync "${copy_opts[@]}" -n --out-format='  %n' "$vault_dir/" \
      "$target_dir/" | grep -v '/$'
    return 0
    ;;
  *)
    echo -e "\033[35mPublish (publish)\033[0m"
    echo "Usage: publish.sh [command]"
    echo ""
    echo -e "\033[33mCommands:\033[0m"
    echo "  publish     - Copy the notes, commit and push (default)"
    echo "  status      - Show which notes differ, without copying"
    echo ""
    echo -e "\033[33mPaths:\033[0m"
    echo "  Vault:      $vault_dir"
    echo "  Repository: $target_dir"
    ;;
  esac
}

# If script is run directly (not sourced), execute the function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  publish "$@"
fi
