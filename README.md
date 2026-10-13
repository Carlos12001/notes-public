# notes-public

The published copy of my notes: a journal of what I do and think, and the
notes I take while reading philosophy. Most of it is in Spanish and some in
English.

The site is [carlos12001.github.io/notes-public][site], built with
[Quartz][quartz], a generator made for Obsidian vaults: it gives each note its
backlinks, a graph, a page per tag and full-text search.

## Structure

| Path | Content |
| --- | --- |
| `src/` | The published notes, in the same folders as the vault |
| `src/index.md` | The home page of the site |
| `src/AGENTS.md` | The vault's rules for agents, copied as they are |
| `AGENTS.md`, `CLAUDE.md` | The rules for agents working in this repository |
| `quartz.config.yaml` | The site's title, language, theme and plugins |
| `publish.sh` | Copies the notes here and pushes them |
| `.markdownlint-cli2.jsonc` | The Markdown rules; `src/` has its own, the vault's |
| `.github/workflows/deploy.yml` | Builds and deploys the site on every push |

Quartz itself is not in this repository. The workflow downloads the version
named in its `QUARTZ_REF` line, puts `src/` in as Quartz's `content/` folder,
adds `quartz.config.yaml` and builds.

## Writing and publishing

The notes are not written here. They are written in one Obsidian vault,
`~/Documents/Synced/Notes`, which pCloud keeps identical on the laptop, the
tablet and the e-reader. This repository is the published copy of that vault.

```bash
./publish.sh status     # Show which notes differ, without copying
./publish.sh            # Copy the notes, commit and push
```

- `publish.sh` mirrors the vault into `src/`: a note deleted or renamed in
  the vault is deleted or renamed here too. Do not edit the notes in `src/`
  by hand, because the next run overwrites them.
- A note is published whole, with the card of properties at its top. Quartz
  reads the card: `tags` become tag pages and `created` is the date shown.
- The site's menu follows the folders. A new note or folder appears on the
  site without any other step.
- What is published: Markdown notes, and whatever sits in a folder named
  `attachments` next to a note, which is where Obsidian puts the images and
  files a note embeds. What is not: a `Private/` folder at the top of the vault,
  `Books/` with the books, `Templates/`, the `README.md` of the vault and of
  each folder, Obsidian's own files, and any other file that is not Markdown.
- To exclude another folder of the vault, add a line such as
  `--exclude='/Masters/'` to the `excludes` list at the top of `publish.sh`.
  The vault's `README.md` explains both ways of keeping a note out.
- The vault's `AGENTS.md` is copied to `src/AGENTS.md` so that an agent
  reading this repository knows the rules of the notes. It is not a page of
  the site: `quartz.config.yaml` ignores it.
- `src/index.md` exists only here; edit it in this repository.
- A push to `main` builds and deploys the site through GitHub Actions. It
  takes a few minutes.

`PUBLISH_VAULT_DIR` points the script at another folder.

Names are in English and plain ASCII, for folders, files and tags, as in the
vault. Only the text of a note may be in Spanish.

## Adding a folder of notes

A new subject with several notes of the same kind gets its own folder, like
`Philosophy/`. The folder is made in the vault, never in `src/`. With a
folder for history notes as the example:

1. **Create the folder** at the top of the vault, named in English with a
   capital letter: `History/`. Create it inside `Private/` instead when it
   must not be published.
2. **Choose its area tag,** in lowercase: `history`. Add it to the list of
   areas in the vault's `README.md`. Every note of the folder carries it.
3. **Write its template,** `Templates/History/Template.md`: the card with
   `created: {{date}}` and the tag, a `#` heading for the title, and the `##`
   headings every note of that kind repeats. Copying
   `Templates/Philosophy/Template.md` and changing it is the quickest way.
4. **Write its `README.md`,** `History/README.md`: what the folder holds, how
   a note is named, and the format of a note with one example. Copy the
   structure of `Philosophy/README.md`.
5. **Add the folder to the structure table** at the top of the vault's
   `README.md`.
6. **Give it a colour in the graph** (optional): in Obsidian's graph
   settings, Groups, a new group with the query `tag:#history`.

Nothing changes in this repository. pCloud carries the folder to the other
devices, and the next `./publish.sh` puts it on the site, where it appears in
the menu by itself. The folder's `README.md` and its template stay in the
vault.

A single note does not need a folder: it goes in the folder that fits, with a
tag for its subject.

## Changing the site

| To change | Edit |
| --- | --- |
| The title of the site | `pageTitle` in `quartz.config.yaml` |
| The text of the home page | `src/index.md` |
| Colors and fonts | `theme` in `quartz.config.yaml` |
| The Quartz version | `QUARTZ_REF` in `.github/workflows/deploy.yml` |

After a Quartz upgrade, open the site and check a note, the search and the
graph. If something broke, put the previous `QUARTZ_REF` back and push.

## Previewing on the laptop

Needs Node 22 or later and `npm`.

```bash
work="$(mktemp -d)"
git clone https://github.com/jackyzha0/quartz.git "$work"
git -C "$work" checkout <QUARTZ_REF>
rm -rf "$work/content"
cp -r src "$work/content"
cp quartz.config.yaml "$work/"
cd "$work"
npm ci
npm install "@quartz-themes/default@^1"
npx quartz plugin install --from-config
npx quartz build --serve      # http://localhost:8080
```

Delete the folder when done.

[site]: https://carlos12001.github.io/notes-public/
[quartz]: https://quartz.jzhao.xyz/
