# pulpcore-selinux

The SELinux policy for Pulp 3.Y releases.

## Building

```
sudo yum install -y selinux-policy-devel policycoreutils
git clone https://github.com/pulp/pulpcore-selinux
cd pulpcore-selinux

make -f /usr/share/selinux/devel/Makefile pulpcore_port.pp
make -f /usr/share/selinux/devel/Makefile pulpcore.pp
make -f /usr/share/selinux/devel/Makefile pulpcore_rhsmcertd.pp
```

## Installing

```
sudo semodule -i pulpcore_port.pp
sudo semodule -i pulpcore.pp
sudo semodule -i pulpcore_rhsmcertd.pp
```

## Labeling pulpcore\_port

**Required**: You must label ports used by Pulp with `pulpcore_port_t` so that the proper type is assigned to the ports and Pulp is allowed to communicate on with the network correctly.

Apply the `pulpcore_port_t` SELinux type to ports 24816 and 24817 with:

`sudo semanage port -a -t pulpcore_port_t -p tcp 24816-24817`


## Uninstalling

Uninstall in the following order:

```
sudo semanage port -d -t pulpcore_port_t -p tcp 24816-24817
sudo semodule -r pulpcore_rhsmcertd
sudo semodule -r pulpcore
sudo semodule -r pulpcore_port
```

# Additional configuration

## Adding support for remote repos running on custom ports

**Optional** By default, pulp is allowed to connect to web servers running on several standard or semi-standard ports: `80, 81, 443, 488, 8008, 8009, 8443, 9000`.

If any of the remote repos you are trying to connect to are hosted on non-standard
HTTP/HTTPS ports, you can configure Pulp to be able to talk to them like in the following example
for port `10011`.

`sudo semanage port -a -t http_port_t -p tcp 10011`

## Adding support for proxy servers running on custom ports

**Optional** By default, pulp is allowed to connect to web proxy servers on several standard or semi-standard ports: `3128, 3401, 4827, 8080, 8118, 8123, 10001-10010`.

If Pulp is configured to use a proxy server (in order to talk to remote repos), but the proxy
server is on a non-standard port, you can configure Pulp to be able to talk to them like in the
following example for port `10012`.

`sudo semanage port -a -t http_cache_port_t -p tcp 10012`

**NOTE**: If you get the following error:

`ValueError: Port tcp/10012 already defined`

That means that the port number is already labelled for some other purpose by SELinux. No change was
made to your system. Run this command instead (substitute `http_port_t` for remote repos):

`sudo semanage port -m -t http_cache_port_t -p tcp 10012`

**NOTE**: Technically Pulp can talk to any remote repo or proxy server running on any SELinux-recognized
ports for web servers or for proxy servers. (They are effectively one cumulative list.)

**NOTE**: To see the complete list of these ports currently recognized on your system, run:
`sudo semanage port -l | grep -E "^http_port_t|^http_cache_port_t|^squid_port_t" | grep tcp`

# Development

## Release Process

See the [Release Guide](docs/dev/guides/release.md)
