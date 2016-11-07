# To install and start the Pulse frontend
- First clone this repository: `git clone git@github.com:openstate/docker-pulse.git`
- Then clone its dependencies:
  - clone Pulse: `git clone git@github.com:18F/pulse.git`
  - clone domain-scan: `git clone git@github.com:18F/domain-scan.git`
  - clone pshtt: `git clone git@github.com:dhs-ncats/pshtt.git`
- `docker-compose build`
- `docker-compose up -d c-pulse`

# To run a new scan on domains
- edit `pulse/meta.yml` to update `domains_url` to point to a URL with a CSV containing the domains to scan; this CSV is currently required to have the following 3 columns in this order: `Domain Name,Domain Type,Agency`
- run `docker exec dockerpulse_c-pulse_1 python -m data.update --scan=here`

# Some background information as to why you need to clone the three repositories above
`Pulse` uses `domain-scan` and expects it to use `ssllabs-scan`, `sslyze` and `pshtt`. `domain-scan`'s Dockerfile includes `ssllabs-scan` and `sslyze`, so we do not need to install them. It does not install `pshtt` though, so we do need to build it ourselves and provide the correct environment variable to run it (which we do using `.pulse-env`).
