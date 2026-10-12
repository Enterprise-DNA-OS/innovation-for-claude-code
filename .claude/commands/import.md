# /import

Rehearse and import Ideanote idea exports.

1. Read CLAUDE.md. Read the record with show first. Confirm the operator supplied the actual values and actor; example values below are fictional.
2. Run:

```bash
npm run innovation -- import ideanote --campaign="Less rework" --file=examples/ideanote-ideas.csv --actor=Mere --dry-run
```

3. Read docs/replace-ideanote.md, map the actual export headers and compare dry-run counts. Remove --dry-run only when the operator has requested the import. Source phase never grants approval.

All commands accept --json. Actor names are attribution, not authentication. 
