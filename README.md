# pulpcore-selinux

The SELinux policy for Pulp 3.Y releases.

## Building

```
sudo yum install -y selinux-policy-devel  policycoreutils-python
git clone https://github.com/pulp/pulpcore-selinux
cd pulpcore-selinux

make  # this performs the building
```

## Installing

`sudo make install-policy`

## Labeling pulp_port

**Required**: You must label your ports with `pulp_port_t` or SELinux won't allow Pulp to
communicate on with the network correctly.

Apply the `pulp_port_t` SELinux label to ports 24816 and 24817 with:

`semanage port -a -t pulp_port_t -p tcp 24816-24817`
