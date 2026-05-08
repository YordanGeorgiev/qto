#!/bin/bash

#------------------------------------------------------------------------------
# @description Zip all projects.
# @example ./run -a do_zip_all_projects
#------------------------------------------------------------------------------
do_zip_all_projects() {

  # Navigate to the application path
  cd "$APP_PATH"

  # Find all directories at depth 1
  find "$APP_PATH" -type d -mindepth 1 -maxdepth 1 | while read -r proj_dir; do
    proj=$(basename "$proj_dir")

    # Remove existing zip file if it exists
    rm -v "$APP_PATH/$proj.zip" 2>/dev/null || true

    # Skip projects based on their last 3 characters or specific names
    [[ "$proj" == *cnf ]] && continue
    [[ "$proj" == *inf ]] && continue
    [[ "$proj" == *qto ]] && continue
    [[ "$proj" == *utl ]] && continue
    [[ "$proj" == *ore ]] && continue
    [[ "$proj" == *gen ]] && continue
    [[ "$proj" == *ode ]] && continue # .vscode
    [[ "$proj" == *mux ]] && continue # .tmux

    # Create a zip file excluding specific directories
    zip -r -y "$APP_PATH/$proj.zip" "$proj" -x '*/.git/*' -x '*/.terraform/*' -x '*/.venv/*'
  done

}
# run-bsh ::: v3.8.2
