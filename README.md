[![](https://images.microbadger.com/badges/image/sgtsquiggs/sabnzbd.svg)](https://microbadger.com/images/sgtsquiggs/sabnzbd)

# sabnzbd

This image is derived from [sgtsquiggs/alpine](https://hub.docker.com/r/sgtsquiggs/alpine/).

[SABnzbd](https://github.com/sabnzbd/sabnzbd) - The automated Usenet download tool!

## Usage
```
docker run \
    --name=sabnzbd \
    -v <path to data>:/config \
    -v <path to data>:/downloads \
    -v <path to data>:/incomplete-downloads \
    -e PGID=<gid> -e PUID=<uid> \
    -p 8080:8080 \
    sgtsquiggs/sabnzbd
```

## Parameters
* `-p 8080:8080` external port 8080 mapping to internal port 8080
* `-v <path>:/config` where configuation files are stored.
* `-v <path>:/downloads` where complete downloads are stored.
* `-v <path>:/incomplete-downloads` where incomplete downloads are stored.
* `-e PGID=<gid>` for Group ID (see below)
* `-e PUID=<uid>` for User ID (see below)

## User and Group ID
Set these to match the user/group ID of shared data volumes. Files written to these volumes will match the
provided uid/gid.

## Acknowledgements

* [linuxserver/sabnzbd](https://github.com/linuxserver/docker-sabnzbd)
