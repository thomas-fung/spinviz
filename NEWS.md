# spinviz 0.0.1.0000

* Removed a duplicate `grDevices` entry from `DESCRIPTION` Imports.
* Added a `tests/testthat` suite covering `diagram_colours()`, `test_colour()`,
  and `injury_heatmap()`.
* `injury_heatmap()` no longer calls `print()` on its result before
  returning it, which previously caused the plot to render twice in
  R Markdown/Quarto documents when the call was left unassigned.
* `injury_heatmap()` now warns when values in the selected sport column
  cannot be converted to numeric, instead of silently coercing them to `NA`.
* `injury_heatmap()`'s documentation for the `palette` argument is now
  regenerated and no longer shows the stale "WIP" placeholder text.
* `test_colour()` now restores the caller's `graphics::par()` settings on
  exit instead of permanently changing the plotting layout (`mfrow`).
* Fixed a documentation typo in `test_colour()` ("coloublind" ->
  "colourblind").
