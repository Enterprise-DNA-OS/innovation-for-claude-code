<h1 align="center">Innovation for Claude Code</h1>

<p align="center">
  <strong>The open-source innovation register that is just a database and Claude Code.</strong>
</p>

<p align="center">
  Created by <a href="https://www.enterprisedna.co"><strong>Enterprise DNA</strong></a>. Free and open source. Works with Claude Code, Codex, OpenCode or Cursor.
</p>

<!-- three-doors -->
<table align="center">
  <tr>
    <td align="center"><strong>Do it yourself</strong><br/>Clone it, run it, own it. Free, MIT.<br/><a href="#quick-start">Quick start</a></td>
    <td align="center"><strong>We customise it</strong><br/>Your fields, your rules, your Ideanote data brought across.<br/><a href="https://enterprisedna.co/omni/book/?utm_source=github&utm_medium=readme&utm_campaign=ideanote">Book a call</a></td>
    <td align="center"><strong>We run it for you</strong><br/>Installed, connected and operated inside Omni. Setup fee, then a retainer.<br/><a href="https://enterprisedna.co/omni/instead-of/ideanote?utm_source=github&utm_medium=readme&utm_campaign=ideanote">How it works</a></td>
  </tr>
</table>

<p align="center">
  <a href="#what-is-this">What is this</a> &bull;
  <a href="#why-no-front-end">Why no front end</a> &bull;
  <a href="#quick-start">Quick start</a> &bull;
  <a href="#the-commands">Commands</a> &bull;
  <a href="#instead-of-ideanote">Instead of Ideanote</a> &bull;
  <a href="#want-it-installed-and-run-for-you">Installed for you</a> &bull;
  <a href="#license">License</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Node-20+-339933?style=flat-square" alt="Node 20+" />
  <img src="https://img.shields.io/badge/PostgreSQL-any-336791?style=flat-square" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/PGlite-embedded-3ecf8e?style=flat-square" alt="PGlite" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=flat-square" alt="MIT License" />
</p>

---

## What is this

Innovation for Claude Code does the job you pay Ideanote for, as a Postgres database and a set of agent commands. There is no web front end. You open the folder in [Claude Code](https://claude.com/claude-code) (or Codex, OpenCode, Cursor: see `AGENTS.md`) and ask for what you want in plain language. It runs the right query, and it can answer questions the Ideanote dashboard cannot.

Ideanote Ultimate starts at US$899 per month for 100 users, equivalent to US$10,788 over twelve months. This is the published starting price, not an observed customer invoice. Smaller Scale plans cost less. [Vendor pricing](https://ideanote.io/pricing), checked 12 October 2026.

Want the same thing with a web front end, or built on a different stack? That is a customisation, and it is exactly what Enterprise DNA does: [book a call](https://enterprisedna.co/omni/book/?utm_source=github&utm_medium=readme&utm_campaign=ideanote).

Run an employee improvement programme: collect ideas into challenges, score them against a fixed rubric, approve pilot spending, measure results and verify outcomes. This base serves a trusted programme coordinator in a manufacturer or professional firm. Enterprise DNA builds the submission screens and team access needed for a wider rollout through Omni by Enterprise DNA, for a setup fee then a retainer.

## Why no front end

- The front end was only ever there because the database was hard to talk to. That is no longer true.
- Your data sits in plain Postgres tables you own. Any tool can read them. No export, no lock-in.
- No seats, no tiers, no add-ons. Read [docs/why-no-front-end.md](docs/why-no-front-end.md) for the honest trade-offs too.

## Quick start

Sixty seconds, no database install (an embedded Postgres runs inside Node):

```bash
git clone https://github.com/Enterprise-DNA-OS/innovation-for-claude-code.git
cd innovation-for-claude-code
npm install
npm run demo
```

Then open the folder in Claude Code and type a slash command. Start with `/attention`. Use a separate empty DATA_DIR and migrate only for real work; never seed demo records into a working database.

### Use it with your own Postgres or Supabase

Copy `.env.example` to `.env`, set `DATABASE_URL`, then `npm run migrate`. Same commands, shared data, no per-seat fee.

## The commands

| Command | Job |
|---|---|
| `/campaigns` | Read challenge goals, closing dates and budgets |
| `/ideas` | List ideas and original source phases |
| `/triage` | Assign the new ideas that need a first review |
| `/criteria` | Read the campaign scoring rubric |
| `/reviews` | Read scores and the reasons behind them |
| `/shortlist` | Compare weighted scores with reviewer coverage |
| `/pilots` | Review pilot targets, actuals and due dates |
| `/outcomes` | Read measured periods and verification status |
| `/budgets` | Compare approved budgets with pilot commitments |
| `/decisions` | Read the reasons for stage decisions |
| `/review-coverage` | Find incomplete scorecards |
| `/department-impact` | Read verified outcomes by department and currency |
| `/attention` | Find unowned, late and quiet work |
| `/compliance` | Review retention and evidence findings |
| `/history` | Read attributed changes |
| `/show` | Read one full record and its decision history |
| `/add` | Add a campaign, idea or criterion |
| `/update` | Change an editable record field |
| `/log` | Record a dated idea note |
| `/start-review` | Send a submitted idea into review |
| `/score` | Score one criterion with a reason |
| `/approve-pilot` | Approve a funded pilot after independent scoring |
| `/finish-pilot` | Record the measured result and evidence |
| `/implement` | Approve implementation after a passed pilot |
| `/reject` | Close an idea with a reason |
| `/record-outcome` | Record a measured outcome period |
| `/verify-outcome` | Verify an outcome as a different person |
| `/close-campaign` | Close a campaign after its ideas are resolved |
| `/import` | Rehearse and import Ideanote idea exports |
| `/export` | Export the whole database to JSON |
| `/weekly-review` | Draft the Monday idea, pilot and outcome review |
| `/draft-decision-pack` | Draft the next approval meeting pack |
| `/draft-pilot-report` | Draft pilot results and measured outcomes |
| `/help` | Read syntax and editable fields |
| `/customise` | Add a field or change a policy with a tested migration |
| `/new-view` | Add a branded read-only report |

All CLI commands accept `--json`. Writes require `--actor=Name`. Case-insensitive names and partial IDs work; ambiguous matches list candidates and exit 1. The actor is an audit label, not authentication. `npm run view` renders two reports; `npm run docs` renders decision packs, pilot reports and outcome statements from brand.json.

| Command | What it does |
|---|---|
| `/...` | ... |

## Instead of ideanote

Export an Ideanote idea collection, save the idea worksheet as UTF-8 CSV and run `npm run innovation -- import ideanote --campaign="Less rework" --file=export.csv --actor=Mere --dry-run`. Map custom headers, compare counts, then remove `--dry-run`. Reimports preserve local approvals. See [the switching guide](docs/replace-ideanote.md) for exact fields and what needs separate reconciliation.

## Architecture

```
innovation-for-claude-code/
  CLAUDE.md                 how the operator wants this run (routing table + house rules)
  AGENTS.md                 the same, for Codex / OpenCode / Cursor / Gemini CLI
  .claude/commands/         the slash commands
  scripts/                  the CLI the commands drive
  scripts/lib/db.mjs        one adapter: DATABASE_URL (pg) or embedded PGlite
  supabase/migrations/      plain SQL schema
  supabase/seed.sql         demo data
  docs/                     the thesis and the migration guide
```

## Built for coding agents

The database, CLI and command recipes work with Claude Code, Codex, OpenCode or Cursor. Ask your coding agent for a new command and have it implement and test the change against the same records.

## Contributing

Issues and pull requests are welcome. Keep the shape: plain SQL, a small CLI, a slash command per recurring job, no front end.

## Want it installed and run for you?

Enterprise DNA installs Innovation for Claude Code for your business, migrates your Ideanote data, connects it to the rest of your tools, and runs it for you as part of **Omni**, our managed Command Center. One setup fee, then a monthly retainer.

- Book a call: [enterprisedna.co/omni/book](https://enterprisedna.co/omni/book/?offer=replace-software&utm_source=github&utm_medium=readme&utm_campaign=ideanote)
- Read more: [enterprisedna.co/omni/instead-of/ideanote](https://enterprisedna.co/omni/instead-of/ideanote?utm_source=github&utm_medium=readme&utm_campaign=ideanote)

## License

MIT. Copyright (c) 2026 Enterprise DNA.

## Ten questions to ask of your own records

Ideanote provides custom analytics too. These are working queries in this base, not claims that the vendor cannot build equivalent reports.

1. Which ideas have no accountable owner? `triage`
2. Which reviews are overdue or have gone quiet? `attention`
3. Which scorecards are missing a reviewer or a criterion? `review-coverage`
4. Which proposals score highest and have complete reviews? `shortlist`
5. Which pilots are past their agreed result date? `pilots`
6. How much of each challenge budget is already committed? `budgets`
7. Which measured outcomes still need independent verification? `outcomes`
8. Which departments have verified outcomes, separated by currency? `department-impact`
9. Who approved each pilot and why? `decisions`
10. Which idea records need a purpose or retention review? `compliance`

## Your first hour: ten things to ask for

1. Put our business name, colours and logo in brand.json.
2. Create the improvement challenge we review each week.
3. Record its owner, objective, currency and budget.
4. Set the evaluation criteria before anyone scores.
5. Rehearse our Ideanote export and compare the counts.
6. Assign the unowned ideas.
7. Show overdue reviews and missing scorecards.
8. Draft the decision pack for the pilot meeting.
9. Record an actual pilot result with evidence.
10. Add our confidentiality field or change our review rule with `/customise`.

## Record controls

Pilot spending requires two completed independent scorecards and remaining budget. Implementation requires a passed pilot with evidence. Outcome claims cover non-overlapping periods and enter totals only after another person verifies them. No automatic messages, patent decisions or regulatory certification. See [the checks and sources](docs/compliance.md).
