# /approve-pilot

Approve a funded pilot after independent scoring.

1. Read CLAUDE.md. Read the record with show first. Confirm the operator supplied the actual values and actor; example values below are fictional.
2. Run:

```bash
npm run innovation -- approve-pilot "Reusable tote trial" --name="Tote pilot" --owner=James --hypothesis="Totes reduce waste" --metric="Disposed cartons per week" --baseline=50 --target=20 --direction=decrease --cost=2000 --due=2026-11-15 --reason="Two scorecards reviewed" --actor=Mere
```

3. Read the returned record and history to verify the change. Stop on ambiguous names or missing evidence.

All commands accept --json. Actor names are attribution, not authentication. 
