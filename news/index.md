# Changelog

## spinviz 0.0.1.0000

- Removed a duplicate `grDevices` entry from `DESCRIPTION` Imports.
- Added a `tests/testthat` suite covering
  [`diagram_colours()`](https://thomas-fung.github.io/spinviz/reference/diagram_colours.md),
  [`test_colour()`](https://thomas-fung.github.io/spinviz/reference/test_colour.md),
  and
  [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md).
- [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)
  no longer calls [`print()`](https://rdrr.io/r/base/print.html) on its
  result before returning it, which previously caused the plot to render
  twice in R Markdown/Quarto documents when the call was left
  unassigned.
- [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)
  now warns when values in the selected sport column cannot be converted
  to numeric, instead of silently coercing them to `NA`.
- [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)’s
  documentation for the `palette` argument is now regenerated and no
  longer shows the stale “WIP” placeholder text.
- [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)’s
  front/back label coordinate tables are now built from a single shared
  lookup (`label_position_lookup()`) instead of two hand-duplicated
  tables, so the views cannot silently drift apart.
- [`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)’s
  combined “both views” label table (`both_label_position_lookup()`) now
  validates its front-only/back-only regions against the same single
  source of truth (`view_exclusive_regions()`) used by the SVG id and
  per-view label lookups, instead of re-encoding which regions are
  one-sided a third time.
- [`test_colour()`](https://thomas-fung.github.io/spinviz/reference/test_colour.md)
  now restores the caller’s
  [`graphics::par()`](https://rdrr.io/r/graphics/par.html) settings on
  exit instead of permanently changing the plotting layout (`mfrow`).
- Fixed a documentation typo in
  [`test_colour()`](https://thomas-fung.github.io/spinviz/reference/test_colour.md)
  (“coloublind” -\> “colourblind”).
