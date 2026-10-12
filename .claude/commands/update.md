# /update

Change an editable record field.

1. Read CLAUDE.md. Read the record with show first. Confirm the operator supplied the actual values and actor; example values below are fictional.
2. Run:

```bash
npm run innovation -- update ideas "Handover checklist" --owner=James --purpose="Evaluate handover improvement" --retention-review=2027-04-01 --actor=Mere
```

3. Read the returned record and history to verify the change. Stop on ambiguous names or missing evidence.

All commands accept --json. Actor names are attribution, not authentication. 
