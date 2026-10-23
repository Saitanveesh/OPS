# OPS — Three-PC Red/Blue Cyber Range

**Status:** First working MVP release available; Python localhost integration tests passed. **Not yet installed or tested on the actual laboratory PCs.**

## Assigned hosts
| Role | PC | Wired LAN IPv4 |
|---|---|---|
| Red Team / bounded request generator | PC-5 | 10.5.114.47 |
| Training storefront, auth API, optional Suricata sensor | PC-6 | 10.5.113.245 |
| Correlation engine, evidence store, SOC & Blue Team portal | PC-7 | 10.5.115.130 |

All systems: 14 GiB RAM, 20 logical CPUs and about 48 GiB free disk.

## Offline-friendly download and extraction

Clone the development branch on one Git-enabled machine:

```bash
git clone -b cyber-range-mvp https://github.com/Saitanveesh/OPS.git
cd OPS
bash unpack.sh
cd OPS-cyber-range
cat README.md
```

If your lab has no GitHub/internet access, download the companion OPS-cyber-range.zip from ChatGPT on another device and copy it to the three lab workstations using USB or SCP. **No pip or Docker is required.**

The repository's `bundle/archive.00.b64`–`archive.03.b64` files contain a release archive split into 4 individually base64-encoded parts. `unpack.sh` decodes and reassembles them, checks the SHA-256 digest, then unpacks the source tree. The full source will be available at `OPS-cyber-range/`.

Expected SHA-256 for the unpacked compressed archive: `82d79de71987242d195ec80960115bbccc3a8728fd62206a37004b14f9cc5bb7`. The exact byte stream from GitHub was checked against the local build with matching per-part and complete-archive CRC32.

## What is implemented

- PC-6: Synthetic RangeMart storefront, deliberately weak training account, JSON event logs, explicit client allowlist, rate limiting and an authenticated containment API.
- PC-7: SOC dashboard, persisted SQLite events/incidents, authentication anomaly correlation, automatic blocks restricted to the assigned PC-5 source and confirmed by target control API, blue-team login, analyst controls, action history.
- PC-5: Single-threaded HTTP probe, 8-attempt auth test, capped 24-request burst, and an offline *precomputed hash index* lookup followed by a real login.
- Optional: Suricata Eve JSON alert ingestion; actual Suricata installation, capture and alerting are not verified yet.

## Boundaries

The shared `10.5.112.0/20` campus subnet is **not** authorization to test every device. Isolate the experiment or secure authorization for precisely the designated three machines and ports. Run tests only against PC-6 TCP 18080. This package contains no DDoS generator. The first release provides application-level enforcement, **not** Suricata inline IPS. The precomputed hash index is not a true rainbow-chain table, and offline lookup is not remotely observable by network IDS.

See `OPS-cyber-range/README.md` after extraction for full PC-specific commands, key provisioning, browser URLs, safety conditions and known limitations.
