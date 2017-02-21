# Initial
git config --global user.name "Alexey Cherkashin"
git config --global user.email "goodniceweb@gmail.com"

# Editor
git config --global core.editor vim

# Aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.fixtypo 'commit --amend --no-edit'
git config --global alias.resetmerge 'reset --merge ORIG_HEAD'
git config --global alias.cleanup "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d"
git config --global alias.lbr "!git for-each-ref --sort='-authordate' --format='%(refname)%09%(objectname:short)%09%(authordate)' refs/heads | sed -e 's-refs/heads/--' | column -t"
git config --global alias.patch "!git format-patch -1 HEAD"
