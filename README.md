# Advent of Code 2021

You can [view the list of puzzles](https://adventofcode.com/2021) at the
official site.

## Programming Language of the Month

Decided on **Factor** once I sorted out a sort of workable environment.

### Contenders

I'd like to do [Factor](https://factorcode.org/) or
[BQN](https://mlochbaum.github.io/BQN/), but:

- getting Factor to run with
  [source in a folder outside the language implementation itself](https://docs.factorcode.org/content/article-add-vocab-roots.html)
  requires messing around with env vars or other boot-time config, and
  getting the GUI listener (IDE and VM basically) to run seemed touch and go
  on macOS. Which is a shame, as the docs are mostly good, and
  [Andrea Ferretti's Factor tutorial](https://andreaferretti.github.io/factor-tutorial/)
  is comprehensive enough to get you places, if only I knew how to get started
  with a basic "here's how to work in a repo with Factor" walkthrough -
  a "second program" walkthrough, rather than "first program".

  But perhaps the
  ["use the work dir" hint from Joe Groff](https://www.mail-archive.com/factor-talk@lists.sourceforge.net/msg04819.html)
  is enough for my needs - just symlink that?

  By golly, that worked:

  ```shell
  cd ~/Applications/factor  # copied from the nightly DMG
  rm -r work
  ln -s /ABSOLUTE/PATH/TO/adventofcode-2021/src/ work
  env AUTHOR='Jeremy W. Sherman' ./Factor.app/Contents/MacOS/factor
  ```

  And then in Factor:

  ```factor
  USE: tools.scaffold
  "palindrome" scaffold-work
  ```

  Indeed created a new vocab in the target src/ folder!
- BQN is entirely too foreign for me to mess around with just now.
  I have a decent theoretical understanding of Forth-likes, but APL
  derivatives? Not at all.

Owing to time constraints, I might wind up doing something boring
that I already know how to use. Alas.

## Layout

- Inputs go in inputs/dayN.txt.
- Code goes in src/dayN.

## Daily Workflow

- Fire up the GUI from the factor/ directory.
- Before scripts/scaffold:
  - "dayNN" dup scaffold-work scaffold-test
  - pbpaste > src/dayNN/input.txt
  - Copy the previous day to get the basic structure down.
- Now:
  - scripts/scaffold 07 # or whatever
- Fill in the example, work on parsing, write some tests.

## Working Around F Keys
One of my keyboards sends weird F key codes.

- Help: F1: `\ word help`
  - See help for a vocab: `"vocab-name" about`, e.g. `"assocs" about`
- Refresh: F2: `refresh-all`
- Errors: F3: `show-error-list`
