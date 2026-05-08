#!/bin/bash
#------------------------------------------------------------------------------
# @description Bump the semantic version recorded in <TARGET_PROJ>/.version and
# @description create an annotated git tag matching it.
# @description Increments wrap at 9: v1.0.9 → v1.1.0, v1.9.9 → v2.0.0 (decimal-style).
# @description Adapted from bnc-cpt-utl version-bump.func.sh — uses the .version
# @description file as source of truth (doc-hub convention) instead of git describe.
# @param TARGET_PROJ - project dir (default: ${APP_PATH}, falls back to PROJ_PATH)
# @param BUMP        - patch | minor | major  (default: patch)
# @example ./run -a do_version_bump
# @example BUMP=minor ./run -a do_version_bump
# @example BUMP=major TARGET_PROJ=/opt/csi/doc-hub ./run -a do_version_bump
#------------------------------------------------------------------------------
do_version_bump() {
  local target_proj="${TARGET_PROJ:-${APP_PATH:-$PROJ_PATH}}"

  if [[ ! -d "$target_proj/.git" ]]; then
    do_log "FATAL Not a git repository: $target_proj"
    return 1
  fi

  local version_file="$target_proj/.version"
  local current
  if [[ -f "$version_file" ]]; then
    current=$(tr -d "[:space:]" < "$version_file")
  else
    do_log "WARN .version not found at $version_file — starting from 0.0.0"
    current="0.0.0"
  fi

  local version="${current#v}"
  local major minor patch
  major=$(echo "$version" | cut -d. -f1)
  minor=$(echo "$version" | cut -d. -f2)
  patch=$(echo "$version" | cut -d. -f3)
  : "${major:=0}"; : "${minor:=0}"; : "${patch:=0}"

  local bump="${BUMP:-patch}"
  case "$bump" in
    patch)
      if [[ "$patch" -ge 9 ]]; then
        patch=0
        if [[ "$minor" -ge 9 ]]; then
          minor=0
          major=$((major + 1))
        else
          minor=$((minor + 1))
        fi
      else
        patch=$((patch + 1))
      fi
      ;;
    minor)
      patch=0
      if [[ "$minor" -ge 9 ]]; then
        minor=0
        major=$((major + 1))
      else
        minor=$((minor + 1))
      fi
      ;;
    major)
      patch=0
      minor=0
      major=$((major + 1))
      ;;
    *)
      do_log "FATAL Invalid BUMP value: $bump. Use patch, minor, or major"
      return 1
      ;;
  esac

  local new_version="${major}.${minor}.${patch}"
  local new_tag="v${new_version}"

  do_log "INFO Project:         $target_proj"
  do_log "INFO Current version: $current"
  do_log "INFO Bump type:       $bump"
  do_log "INFO New version:     $new_version"

  printf "%s" "$new_version" > "$version_file"
  git -C "$target_proj" add .version

  if git -C "$target_proj" diff --cached --quiet; then
    do_log "INFO .version unchanged — no commit needed"
  else
    git -C "$target_proj" commit -m "chore(release): bump version to ${new_version}"
    do_log "OK Committed .version bump"
  fi

  if git -C "$target_proj" rev-parse --verify "refs/tags/${new_tag}" >/dev/null 2>&1; then
    do_log "WARN Tag ${new_tag} already exists — skipping tag creation"
  else
    git -C "$target_proj" tag -a "$new_tag" -m "Release ${new_version}"
    do_log "OK Created tag: $new_tag"
  fi

  do_log "INFO Push with: git -C $target_proj push origin master \"$new_tag\""

  export APP_VERSION="$new_tag"
}
# run-bsh ::: v3.8.2
