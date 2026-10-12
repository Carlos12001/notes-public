# Agent instructions

One Obsidian vault with the owner's notes and the books being annotated.
`README.md` explains the structure and where each copy lives; read it before
changing anything.

## Rules

- **This is the only place the notes are written.** Do not create a second
  vault, a second notes folder or a repository to write in. The owner wants
  one unified place that is easy to maintain.
- **Think before building.** Propose a change to how the vault works and wait
  for the owner's answer before writing scripts or moving folders.
- **The notes are the owner's writing.** Do not rewrite, translate, rewrap or
  reorder their text. Fixing what `markdownlint-cli2` reports is fine when it
  does not change the words.
- **Nothing here is a git repository.** pCloud carries the vault between
  devices. A file deleted or renamed here is deleted or renamed everywhere.
- **`Private/` never leaves the owner's devices and pCloud.** Do not copy
  anything from it to the public repository.
- **Books are never published.** They are copyrighted. Only Markdown notes go
  to the site.
- A PDF in `Reading/` may be open and being annotated on another device. Do
  not rewrite, compress or rename it without the owner's request.

## Conventions

- Each folder of notes has a `README.md` with the format of its notes, and
  `Templates/` has one template per kind of note, named after that folder.
  Follow the format when writing or fixing a note. When the owner changes a
  format, update both the `README.md` and the template. A new folder of
  notes gets both.
- The text of a note is in Spanish or English, as the owner writes it.
  Everything else is in English and plain ASCII: folder names, file names,
  tags, `README.md` and this file. A proper name, such as a book's title or
  a person's name, keeps its language and loses its accents.
- A note is named in Title Case with hyphens: `Immanuel-Kant.md`.
- Links are standard Markdown links with a relative path, with each space
  written as `%20`. Never `[[wiki links]]`.
- Every note starts with the card of properties described in `README.md`:
  `created` and `tags`, and `source` when it comes from a book. Add the card
  to a note that lacks it. Every tag starts with its area (`philosophy`,
  `diary`, `politics`) and subtopics are nested tags under it. Ask the owner
  before adding a new area.
- After the card, a note starts with one `#` heading, which becomes its title
  on the site.
- A book in `Reading/` is named `Author-Short-Title.pdf`, with hyphens and no
  spaces or accents. `README.md` has the full rule. Rename a book inside
  Obsidian, so the links to it are updated.
- Run `markdownlint-cli2` in the vault after editing a note. Its
  configuration turns off the 80-column limit and allows `iframe`, each with
  its reason written next to it.
- `.obsidian/` holds the vault's settings and plugins and is synchronized,
  except the `workspace` files, which each device keeps for itself.

## Publishing

This file is published: `publish.sh` copies it to the public repository as
`src/AGENTS.md`, so that an agent working there has these rules. Do not write
anything private in it.

`~/Repos/notes-public/publish.sh` mirrors the notes into that repository,
writes the site's index and pushes. Run it only when the owner asks to
publish.
