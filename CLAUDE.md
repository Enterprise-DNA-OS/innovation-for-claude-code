# Innovation for Claude Code: operating instructions

This file is the brain. Claude Code reads it at the start of every session. It says who this is for, how work gets done, and the one right way to do each recurring job.

## Who this is for

- **Business:** [YOUR BUSINESS]
- **Operator:** [YOUR NAME], [your role]
- **What matters most:** [the one or two outcomes you care about]

Fill this in once. A worker with context knows. A worker without it guesses.

## How to work

1. **Take a brief, not a script.** The operator describes the outcome. You run the right command and present the answer.
2. **Read before you write.** Before drafting anything about a record, read its full history first.
3. **Plain language.** Short sentences. No filler. Numbers in tables.
4. **Silent success, loud problems.** No play-by-play. Say what broke and what you did about it.
5. **Stop at the line.** Anything that sends, deletes, or faces a customer waits for a yes in this session.

## Routing table: one right way for each recurring job

| When the operator asks for... | Use this |
|---|---|
| Read challenge goals, closing dates and budgets | `/campaigns` |
| List ideas and original source phases | `/ideas` |
| Assign the new ideas that need a first review | `/triage` |
| Read the campaign scoring rubric | `/criteria` |
| Read scores and the reasons behind them | `/reviews` |
| Compare weighted scores with reviewer coverage | `/shortlist` |
| Review pilot targets, actuals and due dates | `/pilots` |
| Read measured periods and verification status | `/outcomes` |
| Compare approved budgets with pilot commitments | `/budgets` |
| Read the reasons for stage decisions | `/decisions` |
| Find incomplete scorecards | `/review-coverage` |
| Read verified outcomes by department and currency | `/department-impact` |
| Find unowned, late and quiet work | `/attention` |
| Review retention and evidence findings | `/compliance` |
| Read attributed changes | `/history` |
| Read one full record and its decision history | `/show` |
| Add a campaign, idea or criterion | `/add` |
| Change an editable record field | `/update` |
| Record a dated idea note | `/log` |
| Send a submitted idea into review | `/start-review` |
| Score one criterion with a reason | `/score` |
| Approve a funded pilot after independent scoring | `/approve-pilot` |
| Record the measured result and evidence | `/finish-pilot` |
| Approve implementation after a passed pilot | `/implement` |
| Close an idea with a reason | `/reject` |
| Record a measured outcome period | `/record-outcome` |
| Verify an outcome as a different person | `/verify-outcome` |
| Close a campaign after its ideas are resolved | `/close-campaign` |
| Rehearse and import Ideanote idea exports | `/import` |
| Export the whole database to JSON | `/export` |
| Draft the Monday idea, pilot and outcome review | `/weekly-review` |
| Draft the next approval meeting pack | `/draft-decision-pack` |
| Draft pilot results and measured outcomes | `/draft-pilot-report` |
| Read syntax and editable fields | `/help` |
| Change a field or rule | `/customise` |
| Add a read-only report | `/new-view` |

If an ask fits nothing here, run the CLI directly (`npm run innovation -- help`) and then propose a new command for it.

## Hard rules

- Never send email or messages from here. Draft to `drafts/`, a person sends.
- Never delete records without an explicit yes in this session. Prefer marking closed or archived.
- Never invent a record. If a name is ambiguous, list the candidates and ask.
- The database is the source of truth. If the answer is not in it, say so.

## Where things live

- `scripts/` the CLI. `scripts/lib/db.mjs` picks `DATABASE_URL` (Postgres, Supabase) or the embedded database in `.data/`.
- `supabase/migrations/` the schema, plain SQL. `npm run migrate` applies it.
- `.claude/commands/` the slash commands. Add one every time the same ask comes twice.
- `docs/` the thesis and the guide for moving off Ideanote.

Built by Enterprise DNA. Installed and run for you as part of Omni: https://enterprisedna.co/omni/instead-of/ideanote

## Domain controls

Read docs/compliance.md before changing policy. Scoring is 1 to 5 with weights per campaign. Two reviewers must complete every criterion before pilot approval. Imported phase is context, not approval. Never annualise outcome amounts or combine currencies. A confidentiality flag does not enforce access. The local database is for a trusted operator.
