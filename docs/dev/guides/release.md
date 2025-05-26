# Release Guide

1. Bump the version number (`sed -i -e 's/1.2.1/1.2.2/g' *.te`).
1. Create a PR with all the changes above and merge it after a review.
1. Create a release on github. It will create the corresponding tag.
1. In that release, copy and paste the git commit titles since the last release
(`git shortlog 1.2.1...master --no-merges | grep -E "^(\s)+\w" | sed -e 's/     /*/'`)
1. Create a corresponding PR ([example](https://github.com/pulp/pulp_installer/pull/524)) for pulp_installer to use the new pulpcore-selinux tag.
(Bump `__pulp_selinux_version` in `roles/pulp_common/defaults/main.yml`)
