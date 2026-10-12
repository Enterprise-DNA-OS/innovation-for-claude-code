# Record checks and sources

Sources checked 12 October 2026. Run `npm run innovation -- compliance`. These are record checks for an operator to review, not a certification or automatic legal decision.

| Rule | Check | Source and limit |
|---|---|---|
| NZ-IPP9 | Idea has no recorded lawful purpose, or missing/overdue retention review | [NZ Privacy Commissioner, Principle 9](https://www.privacy.org.nz/privacy-principles/9/). Personal information must not be retained longer than its lawful purpose requires. The review date is set by the operator; no fixed legal duration is assumed. |
| AU-APP11 | Same review queue for organisations subject to Australian Privacy Principles | [OAIC, APP 11 guidance](https://www.oaic.gov.au/privacy/australian-privacy-principles/australian-privacy-principles-guidelines/chapter-11-app-11-security-of-personal-information). Review destruction or de-identification when no longer required, subject to legal exceptions. |
| LOCAL-OWNER | Open idea lacks an accountable owner | Internal improvement programme policy, not law. |
| LOCAL-EVIDENCE | Finished pilot lacks evidence | Internal evaluation policy, not law. |
| LOCAL-INDEPENDENCE | Same person recorded and verified an outcome | Internal financial review policy, not law. |

Two people must each score all criteria before a pilot can be approved. Submitters cannot score their own ideas or approve their own pilot and implementation. Criteria freeze after scoring starts. A pilot reserves its stated cost against the campaign budget. It must record an actual value and evidence before completion; passing compares actual against the chosen target direction. Only passed pilots can proceed to implementation. Outcome periods cannot overlap for the same idea and require a different verifier before entering totals. Amounts are measured for their stated period, never automatically annualised.

Confidentiality is a label, not access enforcement. The trusted operator and database owner can read all records. All domain tables enable row-level security without public policies; an owner connection is required. For a team deployment, define authenticated roles, backup and restoration, encryption, consent/purpose processes and retention procedures. The actor option is attribution, not proof of identity; the audit log is not tamper-proof against a database owner.

Privacy checks never delete data. Review source exports, notes and backups too, including legal holds and applicable retention duties. No claim is made about ownership of employee inventions, patent rights or intellectual-property clearance. Keep confidential invention material restricted and review it before disclosure.
