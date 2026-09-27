# Network Troubleshooting Guide

## Peering

Check that both sides of each peering report a connected state.

## NSGs

Review:

- effective security rules
- source/destination prefixes
- priorities
- protocol and port
- whether an allow rule is being overridden by a higher-priority deny

## Routes

Check effective routes and next hop before assuming an NSG is the problem.

## DNS

If IP connectivity works but name resolution fails, inspect:

- DNS server configuration
- private DNS links
- record existence
- resolver forwarding

## Network Watcher

Useful tools include:

- Connection troubleshoot
- IP flow verify
- Next hop
- Effective security rules
- topology views

The included `scripts/test-connectivity.sh` provides a parameterised connection-troubleshoot example.
