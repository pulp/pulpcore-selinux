# Extend webserver support

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

!!! note

    If you get the following error:

    `ValueError: Port tcp/10012 already defined`

    That means that the port number is already labelled for some other purpose by SELinux. No change was
    made to your system. Run this command instead (substitute `http_port_t` for remote repos):

    `sudo semanage port -m -t http_cache_port_t -p tcp 10012`

!!! note

    Technically Pulp can talk to any remote repo or proxy server running on any SELinux-recognized
    ports for web servers or for proxy servers. (They are effectively one cumulative list.)

!!! note

    To see the complete list of these ports currently recognized on your system, run:
    `sudo semanage port -l | grep -E "^http_port_t|^http_cache_port_t|^squid_port_t" | grep tcp`
