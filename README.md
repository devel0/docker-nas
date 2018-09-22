# docker-nas

samba file server docker

## prerequisites

- [linux-scripts-utils](https://github.com/devel0/linux-scripts-utils)
- [samba4 domain controller](https://github.com/devel0/docker-dc)
- `/security/nas/root` clear text container root password ( must 600 mode )

## configure

| file | token | replace with |
|---|---|---|
| [krb5.conf](krb5.conf) | `MY.LOCAL` | local domain server name (uppercase) |
| [mycmd.sh](mycmd.sh) | `172.19.0.14` | samba nas server docker ip address |
| | `lob.wb-MY` | replace MY with domain controller name |
| [reset_permissions](reset_permissions) | `MY\` | domain workgroun name |
| [resolv.conf](resolv.conf) | `my.local` | local domain server name |
| | `172.18.0.2` | domain server ip address |
| [run.sh](run.sh) | `nas.my.local` | local nas name |
| [samba.conf](samba.conf) | `192.168.10.201` | ip address of interface which nas bind to |
| | `192.168.10.255/MY` | broadcast address and workgroup to announce to |
| | `MY\` | domain workgroup namespace |

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

then press ctrl+c to stop log and enter container `dk-exec nas` and start first setup ( join domain ) `/dk/first_setup.sh` ; it will join domain by asking for `itadmin` credentials

## commands

- `reload_samba` : reload config gently
- `restart_samba` : restart samba service ( a short interrupt will occur )

## notes

- runs under host network for broadcast discover to work
