# OPS — Three-PC Red/Blue Cyber Range

Development branch: cyber-range-mvp. Date: 2026-10-23.

## Lab machines
| Role | Host | Wired LAN IP |
|---|---|---|
| Red Team | lab-pc5 | 10.5.114.47 |
| Training application + optional Suricata | lab-pc6 | 10.5.113.245 |
| SOC + Blue Team | lab-pc7 | 10.5.115.130 |

All systems: 14 GiB RAM, 20 logical CPUs, 48 GiB free disk.

## Tested MVP
The companion OPS-cyber-range.zip attached in the ChatGPT conversation contains the Python training target, SOC with real correlation and verified containment, red client, browser dashboards, optional Suricata EVE forwarder and detailed deployment README. Python localhost integration tests passed. It has NOT been deployed to the user's three computers yet.

Unzip the package on all three computers. Follow the detailed README.md inside the extracted OPS-cyber-range directory. If internet is unavailable, use USB or SCP to transfer it.

Once copied to a Git-enabled workstation, commit the source files to this branch:

    git clone -b cyber-range-mvp https://github.com/Saitanveesh/OPS.git
    cd OPS
    mkdir -p cyber-range
    cp -a /path/to/OPS-cyber-range/. cyber-range/
    git add cyber-range
    git commit -m 'Add tested OPS three-PC cyber range MVP'
    git push origin cyber-range-mvp

## Security boundary
10.5.112.0/20 is a shared campus subnet, not an authorization boundary. Test only the explicitly assigned application at 10.5.113.245:18080 after authorization, preferably on a dedicated VLAN. The red test client is single-threaded and capped; it is NOT a DDoS generator.

App-level blocking is not a deployed inline network IPS. Suricata is optional network IDS. The offline experiment uses a precomputed hash index rather than genuine rainbow chains; it cannot itself trigger remote IDS evidence.
