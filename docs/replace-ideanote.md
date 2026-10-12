# Bring Ideanote records across

Checked 12 October 2026. Ideanote documents simple and advanced idea exports and workspace exports in its [help centre](https://ideanote.io/help/import-and-export) and [export feature guide](https://ideanote.io/feature/idea-import-and-export). Advanced exports include ratings and field detail. Custom views change the columns, so there is no single fixed header contract published by the vendor.

1. Export the required collection or filtered list from Ideanote. Preserve the original export as a backup. Include a stable idea identifier and title. Save the idea worksheet as UTF-8 CSV if you receive Excel; this importer reads CSV, not XLSX workbooks.
2. Start a clean database with `npm run migrate`, without loading the demo seed. Add a campaign and its review criteria. Use one campaign per collection and a separate campaign for each source workspace whose identifiers overlap.
3. Compare your headers with `examples/ideanote-mapping.json`. Change the mapping file to name your actual columns. That example is a synthetic mapping fixture, not a captured customer export.
4. Rehearse the entire file in one command:

```bash
npm run innovation -- import ideanote --campaign="Less rework" --file=export.csv --mapping=examples/ideanote-mapping.json --actor=Mere --dry-run
```

Remove `--dry-run` after checking row counts and titles. Reimports match the stable identifier within the campaign and update title, description and original source data. They preserve the local submitter, owner, review state, decisions and pilot records. Imported ideas always begin as submitted; source phase is stored separately and never grants an approval. Every original column stays in source_data, including values not mapped to active fields.

| Destination | Default recognised column names |
|---|---|
| External identifier | ID, Idea ID |
| Name | Title, Idea, Name |
| Description | Description, Content |
| Submitter | Submitter, Author, Created by |
| Department | Department, Team |
| Source phase | Phase, Status, Stage |

Header matching ignores case. Use the mapping file for any custom or translated headers. Duplicate IDs in a file, malformed CSV, missing identifiers and empty files fail before changes commit. Dry runs roll back the records and audit entries. An error rolls back the whole import. Match record counts, then inspect a sample with `show ideas` and compare the retained raw columns.

Comments, historical ratings, attachments, invitations, access permissions, automations and prior approvals are not reconstructed from the idea worksheet. Keep the full export, reconcile those separately and configure access before moving real personal information. Source columns are retained as evidence, not silently converted into trusted local decisions. The database has no public access policies. No emails or invitations are sent.

A switch-in-a-day means export, map, rehearse and compare this idea register. Broader history and team access need their own acceptance checks. Enterprise DNA handles those requirements in the customised version through Omni by Enterprise DNA, with a setup fee then a retainer.
