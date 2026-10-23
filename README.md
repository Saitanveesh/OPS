# OPS V2 — Live SOC Cyber Range

**Status:** Local Python/HTTP regression tests passed on 2026-10-23. The three-machine LAN deployment and genuine Suricata capture are not yet verified.

## Lab topology

- PC-5 (10.5.114.47): Red Team bounded request client.
- PC-6 (10.5.113.245): fictional training storefront, audit and app-level blocking.
- PC-7 (10.5.115.130): SOC correlation and Blue Team console, SSE telemetry.

## Validation

Verified on localhost: server boot/health, all three role views and static assets, SSE JSON snapshots, six real failed synthetic account logins → correlation → verified 403 block, denied unauthorized controls/ingest, wrong Blue password, authenticated Blue release → 200 recovery, source-scoped controls, deduplicated and validated Suricata-format injected alert (not actual capture), measured chart series, bounded request-rate scenario → incident → 403. Python compiled and JavaScript passed Node syntax parser.

**Limitations:** No inline Suricata IPS; Suricata-format test-event injection is not live IDS capture. A low-volume HTTP burst is not DDoS; a hash index lookup is not rainbow-chain cracking.

## Start

After unpacking the V2 source archive, read `OPS-cyber-range-v2/README.md` for full PC-7 → PC-6 → PC-5 setup, then locally run:

```bash
cd OPS-cyber-range-v2
python3 tests/test_e2e.py
```

## Safety

The laboratory 10.5.112.0/20 campus subnet is shared infrastructure, not a blanket attack target. Get explicit authorization and preferably isolate the three assigned PCs. Only target PC-6's authorized training port 18080. Keep private control/ingestion keys and Blue credentials out of Git.

The branch's release bundle may be reconstructed with the checksum-verified `unpack-v2.sh` script.
