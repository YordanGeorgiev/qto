# how to add files to the git 
git add --all; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" \
git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com" # --amend
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git push
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git pull

# OBS AMMEND AND git push FORCE !!
git add --all ; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg " git commit -am "$git_msg" \
   --author "Yordan Georgiev <yordan.georgiev@gmail.com>" --amend && \
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg " git push --force
