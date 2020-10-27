# pulpcore-selinux

The SELinux policy for Pulp 3.Y releases.

## Building

```
sudo yum install -y selinux-policy-devel  policycoreutils
git clone https://github.com/pulp/pulpcore-selinux
cd pulpcore-selinux

make -f /usr/share/selinux/devel/Makefile pulpcore_port.pp
make -f /usr/share/selinux/devel/Makefile pulpcore.pp
make -f /usr/share/selinux/devel/Makefile pulpcore_rhsmcertd.pp
```

## Installing

```
semodule -i pulpcore_port.pp
semodule -i pulpcore.pp
semodule -i pulpcore_rhsmcertd.pp
```

## Labeling pulpcore\_port

**Required**: You must label ports used by Pulp with `pulpcore_port_t` so that the proper type is assigned to the ports and Pulp is allowed to communicate on with the network correctly.

Apply the `pulpcore_port_t` SELinux type to ports 24816 and 24817 with:

`semanage port -a -t pulpcore_port_t -p tcp 24816-24817`


## Uninstalling

Uninstall in the following order:

```
semanage port -d -t pulpcore_port_t -p tcp 24816-24817
semodule -r pulpcore_rhsmcertd
semodule -r pulpcore
semodule -r pulpcore_port
```

# Development

## Release Process

See the [Release Guide](RELEASING.md)
