# Changelog

## 0.2.0 (2026-03-26)

### Breaking changes

- Ruby >= 3.1 is now required (was >= 2.5)

### Features

- Add `ので` as a standalone JOSHI particle, correcting an accidental concatenation in the particle list
- Add optional Sentry context (`Sentry.set_context`) before segmentation — zero hard dependency, guarded by `defined?(Sentry)`
- Add `reset_config!` to reset configuration to defaults
- Add `examples/` — a minimal single-file Rails app demonstrating `zabon_translate` with locale switching

### Fixes

- `Segment#hiragana?` was returning `MatchData` instead of a boolean
- `Analyzer#segments` had implicit operator precedence on a compound condition; added explicit parentheses
- `Helper#zabon_translate` was detecting missing translations via a brittle string sniff (`include?("translation_missing")`); replaced with `I18n.exists?`
- `Helper#zabon_translate` called `strip_tags` via a module method that shadowed `ActionView::Helpers::SanitizeHelper#strip_tags` in the ancestor chain; inlined the `ActionView::Base.full_sanitizer` call directly
- `require "uri"` added before `require "action_view"` to fix a `NameError` on Ruby 3.1 where `URI` is not pre-loaded
- `Zabon::Helper` now works correctly when included in a plain controller or any non-`ActionView::Base` context

### Changes

- Ruby 3 idioms adopted throughout: endless methods (`Segment`), `Hash#except` (`Helper`), `Struct keyword_init:` (`Configuration`)
- CI matrix updated to Ruby 3.1, 3.2, 3.3, 3.4
- Upstream copyright notice for mikan.js (trkbt10) added to `LICENSE.txt`
- `examples/` excluded from the gem package

## 0.1.0

Initial release.
