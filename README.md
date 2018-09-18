# docker-nas

samba file server docker

## prerequisites

- [linux-scripts-utils](https://github.com/devel0/linux-scripts-utils)
- [samba4 domain controller](https://github.com/devel0/docker-dc)
- `/security/nas/root` clear text container root password ( must 600 mode )

## install

```
./build.sh
./run.sh
```

after run follow message will appears

```
===> SERVER READY <===

press ctrl+c to stop docker logs and return to shell

- dk-exec nas to enter container
- /dk/first_setup.sh to initialize dc member
======================
```

then press ctrl+c to stop log and enter container `dk-exec nas` and start first setup ( join domain ) `/dk/first_setup.sh`

## commands

- `reload_samba` : reload config gently
- `restart_samba` : restart samba service ( a short interrupt will occur )

## notes

- runs under host network for broadcast discover to work
