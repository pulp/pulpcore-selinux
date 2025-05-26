# Overview

The SELinux policy for Pulp 3.Y releases.

## Quickstart

### Building

```
sudo yum install -y selinux-policy-devel policycoreutils
git clone https://github.com/pulp/pulpcore-selinux
cd pulpcore-selinux

make -f /usr/share/selinux/devel/Makefile pulpcore_port.pp
make -f /usr/share/selinux/devel/Makefile pulpcore.pp
make -f /usr/share/selinux/devel/Makefile pulpcore_rhsmcertd.pp
```

### Installing

```
sudo semodule -i pulpcore_port.pp
sudo semodule -i pulpcore.pp
sudo semodule -i pulpcore_rhsmcertd.pp
```

### Labeling pulpcore_port

**Required**: You must label ports used by Pulp with `pulpcore_port_t` so that the proper type is assigned to the ports and Pulp is allowed to communicate on with the network correctly.

Apply the `pulpcore_port_t` SELinux type to ports 24816 and 24817 with:

`sudo semanage port -a -t pulpcore_port_t -p tcp 24816-24817`


### Uninstalling

Uninstall in the following order:

```
sudo semanage port -d -t pulpcore_port_t -p tcp 24816-24817
sudo semodule -r pulpcore_rhsmcertd
sudo semodule -r pulpcore
sudo semodule -r pulpcore_port
```
