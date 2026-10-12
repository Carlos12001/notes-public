# Agent instructions

This repository is the published copy of the owner's notes. `README.md`
explains its structure and how the site is built; read it before changing
anything.

## The notes are not written here

- The notes live in an Obsidian vault on the owner's devices. `publish.sh`
  mirrors the vault into `src/` and overwrites it on every run. Do not edit a
  note in `src/`: the change is lost at the next publish. Ask the owner to
  change it in the vault.
- The rules of the notes are in [`src/AGENTS.md`](src/AGENTS.md), which is
  the vault's own agent file, copied as it is. It covers the card of
  properties, tags, names and the owner's writing. Read it before touching a
  note anywhere.
- What can be edited here: `README.md`, this file, `publish.sh`,
  `quartz.config.yaml`, `src/index.md` and the workflow in `.github/`.

## Rules

- **Never add what the vault keeps private.** `publish.sh` leaves out the
  vault's `Private/` folder, the books in `Reading/` and every file that is
  neither Markdown nor inside a folder named `attachments`.
  Do not copy any of them here by hand, and do not weaken the `excludes` list
  without the owner's request.
- **Names are in English and plain ASCII:** folders, files and tags. Only the
  text of a note may be in Spanish.
- **Do not rewrite the owner's text.** Fixing what `markdownlint-cli2` reports
  is fine when it does not change the words.
- **Commits carry the owner's name only.** Do not add a co-author line.
- Run `markdownlint-cli2` before committing. `src/` has its own rules, the
  vault's.
- Do not run `publish.sh` unless the owner asks to publish: it commits and
  pushes, and a push deploys the site.

## Checking a change

```bash
bash -n publish.sh          # Syntax
./publish.sh status         # Shows what would change, copies nothing
markdownlint-cli2           # Markdown rules
```

After a push, the workflow takes a few minutes. Check that it passed with
`gh run list -L 1` and open the site.
