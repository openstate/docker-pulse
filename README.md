# To install and start the Pulse frontend
- First clone this repository: `git clone git@github.com:openstate/docker-pulse.git`
- `cd docker-pulse`
- In `docker-compose.yml` you might want to remove the line containing `- nginx-load-balancer` listed in the networks section of the `c-pulse` service as well as the last three lines (shown below) as they are specific to our setup and not needed for general usage:
```
  nginx-load-balancer:
    external:
      name: docker_nginx-load-balancer
```
- Then clone its dependencies:
  - clone [Pulse](https://github.com/openstate/pulse): `git clone git@github.com:openstate/pulse.git`
  - clone [domain-scan](https://github.com/siccovansas/domain-scan): `git clone git@github.com:siccovansas/domain-scan.git`
  - clone [pshtt](https://github.com/dhs-ncats/pshtt): `git clone git@github.com:dhs-ncats/pshtt.git`
- `docker-compose build`
- `docker-compose up -d c-pulse`

# To run a new scan on domains
- edit `pulse/meta.yml` to update `domains_url` to point to a URL with a CSV containing the domains to scan; this CSV is currently required to have the following 3 columns in this order: `Domain Name,Domain Type,Agency`
- run `docker exec dockerpulse_c-pulse_1 python -m data.update --scan=here`
- once finished, restart `docker-compose restart`

# Some background information as to why you need to clone the three repositories above
`Pulse` uses `domain-scan` and expects it to use `ssllabs-scan`, `sslyze` and `pshtt`. `domain-scan`'s Dockerfile includes `ssllabs-scan` and `sslyze`, so we do not need to install them. It does not install `pshtt` though, so we do need to build it ourselves and provide the correct environment variable to run it (which we do using `.pulse-env`).
