#!/usr/bin/env bash
# Author: Corey Osman
# Date: 4/2/2022
# Purpose: Auto promote tag in puppet control repo to specified environment
# Requirements: 
#  - yq
#  - git
#  - rg (ripgrep)

# Gets the tags of your control repo and updates your puppet environment with that tag then creates a commit

control_repo_remote='https://github.com/nwops/kontrol-repo-yaml.git'
r10k_environments_file='r10k-environments.yaml'


echo 
echo "Welcome to the auto promote script, to get started please specify a version to promote: "
echo "If you do not see your version, the tag in the control repo must be created first."
echo 
versions=$(git ls-remote $control_repo_remote | rg 'tags/(v?[0-9,.]+)' -or '$1' - )

select version in $versions
do
  echo "selected version ${version}"
  break
done
git fetch origin
branch="promote-${version}"
git checkout -b $branch origin/main

echo "Select an environment to promote ${version} to:"
envs=$(yq 'keys | .[]' r10k-environments.yaml)
select env in $envs
do
  echo 
  while true
  do
      read -r -p "Promote ${version} to ${env}? [Y/n] " input
 
      case $input in
            [yY][eE][sS]|[yY])
                  yq -i ".${env}.version = \"1.1.1\"" r10k-environments.yaml 
                  git add r10k-environments.yaml
                  git commit -m "Promoting version ${version} to environment ${env}"
                  echo "If you are ready to push run: git push origin ${branch}"
                  break
                  ;;
            [nN][oO]|[nN])
                  break
                  ;;
            *)
                  echo "Invalid input..."
                  ;;
      esac      
  done
    break;
done
