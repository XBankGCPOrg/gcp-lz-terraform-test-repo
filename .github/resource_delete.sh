#!/bin/bash

echo "starting"
# Get the list of projects with the "test" suffix
projects=$(gcloud projects list --format="value(Name)" | grep "test$")
 echo "projects: $projects"

# Check if there are projects with the "test" suffix
if [ -z "$projects" ]; then
  echo "No projects found with the 'test' suffix."
else
  echo "Deleting projects with the 'test' suffix..."

  # Loop through the projects and delete them
  for project in $projects; do
    echo "Deleting project: $project"
    projectID=$(gcloud projects list --filter="name:$project" --format="value(projectId)")

    gcloud projects delete "$projectID" --quiet
  done
  echo "Projects deleted successfully."
fi

echo "Deleting Folder with test suffix"

folders=$(gcloud resource-manager folders list --organization=125788106052 --format="value(DISPLAY_NAME)" | grep "test$")

# Check if there are folders with the "test" suffix
if [ -z "$folders" ]; then
  echo "No folders found with the 'test' suffix."
else
  echo "Deleting folders with the 'test' suffix..."
  # Loop through the folders and delete them

  for folder in $folders; do
    echo "Deleting folder: $folder"
    folderId=$(gcloud resource-manager folders list --organization=125788106052 --filter="DISPLAY_NAME:$folder" --format="value(ID)")

    gcloud resource-manager folders delete "$folderId"
  done
  echo "Projects deleted successfully."
fi