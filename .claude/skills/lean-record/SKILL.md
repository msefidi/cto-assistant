---
name: lean-record
description: >-
  Write a topic's docs/log.md and docs/decisions.md lean. Use when logging an
  event or result, recording a decision, or pruning a log or decisions file
  that has grown heavy.
---

# Lean record

A topic's log and decisions are its **record**: what happened and what was decided, kept so that a later session can rebuild the story in a minute. Current state lives in the brief (`AGENTS.md`); the detail lives in the source (the mail, the Notion page, the vendor's docs). The record holds only the **turning points** between them.

## The keep test

An item earns its place in the record only if it does one of these:

- changes the topic's state (a decision, an offer, a signature, a deadline that moved);
- is a finding that a later decision rests on (a vendor fact, a price, a legal position, a contradiction still open);
- corrects an earlier entry that would otherwise mislead.

Everything else stays out: which pages were read and when, fetch failures, retries, page update dates, version numbers, quotes whose wording does not matter, side findings that no option depends on, and anything the brief already states.

## Writing an entry

- **One entry per event or subject per day.** Several research passes on one vendor in one session make one entry, not one per question.
- Lead with the result. Two to five sentences, or a short bulleted list when one entry holds several findings on one subject.
- Mark vendor claims once, in the heading or the opening clause, rather than on every line.
- Close with one bracket: who, and where the original is (`email "subject"`, `Notion Meetings "page"`, `session with Mahyar`). The bracket is the pointer to the detail; the entry is never a copy of it.
- A correction names what it replaces in one clause ("this corrects the connector line of 19 Nov").
- Prices and contract terms are fine here (the repo is the place for them); one figure per item, the arithmetic left to the source or deck.

## Writing a decision

- One sentence: what was decided, then `(who, where)`. Add a reason only when the decision would read wrong without it.
- Only decisions later work relies on. A meeting date or a next step goes in the brief's Status, not here.
- Decisions taken together in one meeting on one subject share one line.
- A changed decision gets a new line naming the one it replaces.

## Pruning

Two reaches:

- **Uncommitted entries** (written in this session or not yet pushed): prune them yourself before the session ends, whenever they fail the keep test.
- **Committed entries:** prune only when Mahyar asks. They stay recoverable in git, so once asked, cut firmly.

1. Read the whole log and decisions file, and the brief's Status.
2. Apply the keep test to every entry and every decision line. Merge same-subject entries, fold corrections into the fact they correct, shrink history before the topic opened to one line per event, and drop references to files that no longer exist.
3. Keep the chain intact: each decision still traceable to the event or finding behind it.
4. Report word counts before and after and what kinds of detail were dropped, and leave the commit to Mahyar.

Done when every remaining entry passes the keep test, every file it names exists, and the brief's Status still matches the newest entries.
