context("Reading JSON Files")

testthat::test_that("StreamingHistory reading test: dimensions, column types and type of object", {
  p <- make_streaming_history_dt("DataFromSpotify")
  expect_equal(dim(p), c(100, 4))
  expect_is(p[[1]], "character")
  expect_is(p[[2]], "character")
  expect_is(p[[3]], "character")
  expect_is(p[[4]], "integer")
  expect_is(p, "data.table")
  
})

testthat::test_that("SearchQueries reading test: dimensions, column types and type of object", {
  p <- make_search_queries_dt("DataFromSpotify")
  expect_equal(dim(p), c(10, 3))
  expect_is(p[[1]], "Date")
  expect_is(p[[2]], "character")
  expect_is(p[[3]], "character")
  expect_is(p, "data.table")
})

testthat::test_that("prepare_playlist reading test: dimensions, column types and type of object", {
  p <- prepare_playlists("DataFromSpotify")
  expect_equal(dim(p), c(199, 3))
  expect_is(p[[1]], "character")
  expect_is(p[[2]], "character")
  expect_is(p[[3]], "character")
  expect_is(p, "data.table")
})
