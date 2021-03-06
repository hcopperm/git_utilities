git_utilities
=============

Installation
------------

```sh
git clone git@github.com:hcopperm/git_utilities.git
```

You might also have to do this:
```sh
brew upgrade hub
```

If you add it to your path then you can run `make_pr.sh` from any directory

Usage
-----
The script `make_pr.sh` opens a pull request template in `vi`, and when that file is edited and closed, it calls `hub pull-request`, passing the template you just edited  to the `--file` flag. 


```sh
# you can pass two arguments
./make_pr.sh -h ${feature_branch} -b ${master_branch}
# if you just pass the feature branch name
# it will make pull request against master_newui
./make_pr.sh -h ${feature_branch}
# if you don't pass any arguments
# it will make a PR for the branch you are currently on
# against master_newui
./make_pr.sh
# pass -H for help
./make_pr.sh -H
>> Usage...
```

