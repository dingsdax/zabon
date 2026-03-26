# Agent Guidelines

## Repository overview

zabon is a Ruby gem for Japanese text segmentation (Kinsoku Shori / 禁則処理).
It ports the mikan.js algorithm to Ruby and integrates with Rails via `ActionView::Helper`.

## Running checks

```bash
bundle exec rake          # full suite: bundler-audit, rubocop, tests
bundle exec rake test     # tests only
bundle exec rubocop       # linter only
```

All three must be green before committing.

## Code conventions

- Ruby 3.1+ required; use Ruby 3 idioms: endless methods, `Hash#except`, `Struct keyword_init:`.
- `frozen_string_literal: true` on every file.
- Double-quoted strings (`EnforcedStyle: double_quotes` in `.rubocop.yml`).
- Predicate methods return a plain boolean — use `Regexp#match?`, never `match`.

## constants.rb encoding

`lib/zabon/constants.rb` stores some voiced hiragana particles in NFD form (e.g. `で` = `\u3066\u3099`).
This is **load-bearing**: those particles intentionally do not match NFC strings.
Never normalise this file to NFC. When editing it, use byte-level operations and verify
`test_sentence6` and `test_sentence8` still pass.

## Commits

Follow conventional commits (`fix:`, `feat:`, `ref:`, `test:`, `chore:`, `ci:`, `license:`, `meta:`).
One logical change per commit. Include `Co-Authored-By:` when AI-generated.

## CI matrix

Ruby 3.1, 3.2, 3.3, 3.4 on ubuntu-latest. Always verify fixes on **all** matrix versions locally
before pushing — incompatibilities between Ruby versions are not always obvious.

## Tests

Tests in `test/zabon_test.rb` must satisfy `expected.join == source` — the segmentation must be
lossless. When adding new test sentences, run `Zabon.split(source)` first to get the real output,
then copy it into `expected`; do not guess segment boundaries.

## Attribution

zabon is a port of [mikan.js](https://github.com/trkbt10/mikan.js) by trkbt10 (MIT).
The upstream copyright notice is preserved in `LICENSE.txt` — do not remove it.
