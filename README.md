git_utilities
=============

Installation
------------

```sh
git clone git@github.com:hcopperm/git_utilities.git
```

Usage
-----

```sh
# you can pass two arguments
./make_pr ${feature_branch} ${master_branch}
# if you just pass the feature branch name
# it will make pull request against master_newui
./make_pr ${feature_branch}
# if you don't pass any arguments
# it will make a PR for the branch you are currently on
# against master_newui
./make_pr

```

