# Audio sythesis overlay

This is a gentoo overlay for various audio synthesis apps that are not available in mainline repo

# Included program

* Bitwig (v3+)
* Faust

More to come

## Installation
### General
```bash
# make sure the repo directory exists
mkdir /etc/portage/repos.conf

# install our repo
cat << 'EOF' > /etc/portage/repos.conf/synthesis-overlay.conf
[synthesis-overlay]
location = /usr/local/portage/synthesis-overlay
sync-type = git
sync-uri = https://github.com/antisvin/synthesis-overlay.git
EOF

# sync
emaint -r synthesis-overlay sync
```

For more information on the subject, please, check: https://wiki.gentoo.org/wiki//etc/portage/repos.conf

# java
We have removed the bundled jre binary so we can setup and use a system-wide version. Please, read: https://wiki.gentoo.org/wiki/Java in order to be able to setup `oracle-jre-bin`. You must set this VM as your user's VM using `eselect java-vm`. It may be necessary to run ``env-update; source /etc/profile`` if you've just installed this JVM.

# Bug, comments and requests
Please post a ticket here on GitHub.
