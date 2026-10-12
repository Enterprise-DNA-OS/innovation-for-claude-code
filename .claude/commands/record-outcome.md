# /record-outcome

Record a measured outcome period.

1. Read CLAUDE.md. Read the record with show first. Confirm the operator supplied the actual values and actor; example values below are fictional.
2. Run:

```bash
npm run innovation -- record-outcome "Dispatch notes" --name="Measured October reduction" --amount=350 --start=2026-11-01 --end=2026-11-30 --evidence="Finance evidence reference" --actor=James
```

3. Read the returned record and history to verify the change. Stop on ambiguous names or missing evidence.

All commands accept --json. Actor names are attribution, not authentication. 
