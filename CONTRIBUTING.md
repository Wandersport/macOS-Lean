# Contributing to macOS Lean

This is a research-first documentation project. Submit corrections or test evidence through issues and pull requests, not unsolicited new auto-execution scripts.

## Proposing an optimization

Provide the **exact Mac model, macOS build, SIP state, the upstream tool commit, reproducible commands, features affected, rollback, security consequences and benchmark results**. If a claim is from an author or a Reddit anecdote, attribute it clearly; do not promote it to verified fact.

For changes involving launchd labels, include *why* the label is optional, which frameworks depend on it and how to confirm no charge, sleep, auth, update or security regression. Screen captures should redact all personal account details.

## Before merging

- Run python3 -m unittest discover -s tests -v.
- Run bash -n on .sh files.
- Do not commit install one-liners that execute unreviewed main branch content as root.
- Do not insert private keys, Apple account details, tokens, logs with personal information or macOS device serials.
- Respect upstream authorship and license. References to projects are not endorsements.
- All Experimental SIP-off claims must be labelled as security-reducing and not a stable recommendation.
- Cross-version comparisons require controlled same-device baselines.

## Project policy

An accepted contribution to a **research guide** does not certify its instructions for all hardware. Stable profile promotion requires real M4 testing plus rollback, with major macOS builds documented separately. Maintainers may reject changes that promise unsupported FPS/battery/RAM gains.
