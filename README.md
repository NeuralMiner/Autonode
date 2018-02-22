GridcoinAutoNode
===============

A script that automatically sets up a Gridcoin full node as a daemon (`gridcoinresearchd`) under a `gridcoin` user.

Tested on:

- Ubuntu Trusty (14.04)
- Ubuntu Xenial (16.04)
- Debian Jessie (8)
- Debian Stretch (9)

One Liner - DO NOT run without reading code first!
--------------------------------------------------

    wget https://raw.githubusercontent.com/gridcoin-community/Autonode/dev/GridcoinAutoNode.sh && sudo bash GridcoinAutoNode.sh && source .bashrc

Notes
-----

This script installs:
- unzip
- software-properties-common
- sudo
- gridcoinresearchd (and dependencies)
- curl
- apt-transport-https (Debian)

This script:
- Automatically figures out your distro and installs the daemon (`gridcoinresearchd`) for that specific distro.
- Creates a `gridcoin` user to run `gridcoinresearchd` (safer than running client as root).
- Downloads snapshot instead of syncing from block 0 (edit script if you don't want it to do this).
- Creates a `grc` alias (for instance, you can run `grc getinfo`).
- Starts daemon on script completion.