sample_injury_data <- function() {
  subcategory <- c(
    "Head",
    "Neck",
    "Shoulder",
    "Chest",
    "Upper Arm",
    "Elbow",
    "Abdomen",
    "Forearm",
    "Hip Groin",
    "Wrist",
    "Hand",
    "Thigh",
    "Knee",
    "Lower Leg",
    "Ankle",
    "Foot",
    "Thoracic Spine",
    "Lumbosacral"
  )
  data.frame(
    Region.area = rep("Example", length(subcategory)),
    Subcategory = subcategory,
    boxing = c(15, 5, 18, 12, 20, 6, 10, 14, 9, 9, 11, 3, 16, 13, 7, 8, 18, 22)
  )
}

test_that("label_position_lookup shares identical rows for unchanged regions", {
  front <- spinviz:::label_position_lookup("front")
  back <- spinviz:::label_position_lookup("back")

  # These regions use the same coordinates in both views; Head/Neck/
  # Shoulder/Forearm/Hip Groin intentionally differ between views.
  common_regions <- c(
    "Chest",
    "Upper Arm",
    "Elbow",
    "Wrist",
    "Hand",
    "Thigh",
    "Knee",
    "Lower Leg",
    "Ankle",
    "Foot"
  )

  merged <- merge(
    front,
    back,
    by = "Region.area",
    suffixes = c(".front", ".back")
  )
  merged <- merged[merged$Region.area %in% common_regions, ]
  expect_equal(merged$label_x.front, merged$label_x.back)
  expect_equal(merged$label_y.front, merged$label_y.back)
  expect_equal(merged$target_x.front, merged$target_x.back)
  expect_equal(merged$target_y.front, merged$target_y.back)
})

test_that("label_position_lookup includes view-only regions", {
  front <- spinviz:::label_position_lookup("front")
  back <- spinviz:::label_position_lookup("back")

  expect_true("Abdomen" %in% front$Region.area)
  expect_false("Abdomen" %in% back$Region.area)
  expect_true(all(c("Thoracic Spine", "Lumbosacral") %in% back$Region.area))
  expect_false(any(c("Thoracic Spine", "Lumbosacral") %in% front$Region.area))
})

test_that("injury_heatmap returns a ggplot for a single view", {
  df <- sample_injury_data()
  p <- injury_heatmap(df, "boxing", "front", sex = "male", show_values = FALSE)
  expect_s3_class(p, "ggplot")
})

test_that("injury_heatmap returns a patchwork object for 'both' views", {
  df <- sample_injury_data()
  p <- injury_heatmap(df, "boxing", "both", sex = "female")
  expect_s3_class(p, "patchwork")
})

test_that("injury_heatmap does not call print() as a side effect", {
  # injury_heatmap() used to call print() explicitly before returning,
  # which forces a render even when the result is only assigned (causing
  # double rendering in knitr/Quarto documents). Guard against a
  # regression by checking the function body directly.
  body_text <- paste(deparse(body(injury_heatmap)), collapse = "\n")
  expect_no_match(body_text, "(?<![.[:alnum:]_])print\\(", perl = TRUE)
})

test_that("injury_heatmap returns a ggplot for a single view without printing", {
  df <- sample_injury_data()
  p <- injury_heatmap(df, "boxing", "front", show_values = FALSE)
  expect_s3_class(p, "ggplot")
})

test_that("injury_heatmap validates its arguments", {
  df <- sample_injury_data()
  expect_snapshot(error = TRUE, injury_heatmap(df, "not_a_column", "front"))
  expect_snapshot(error = TRUE, injury_heatmap(df, "boxing", "sideways"))
  expect_snapshot(
    error = TRUE,
    injury_heatmap(df, "boxing", "front", opacity = 2)
  )
})

test_that("injury_heatmap warns when injury values are not numeric", {
  df <- sample_injury_data()
  df$boxing[1] <- "not-a-number"
  expect_snapshot(invisible(injury_heatmap(
    df,
    "boxing",
    "front",
    show_values = FALSE
  )))
})
