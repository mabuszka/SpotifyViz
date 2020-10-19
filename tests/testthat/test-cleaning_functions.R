context("Cleaning functions")
testthat::test_that("continuous_listening test: checks numbers of session", {
  expect_equal(continuous_listening(spotifyviz::clean_stream_his, 10)[[8]][1:30],
               c(rep.int(1, 29), 2))
  expect_equal(continuous_listening(spotifyviz::clean_stream_his[30], 10)[[8]], 1)
})

testthat::test_that("filter_search_queries function test: checks filtering by date", {
  expect_true(all.equal(
    spotifyviz::clean_search_queries,
    filter_search_queries(spotifyviz::clean_search_queries, "19.09.10", "19.10.10")
  ))
  expect_true(all.equal(
    spotifyviz::clean_search_queries[1:3],
    filter_search_queries(clean_search_queries, "19.09.30", "19.09.30")
  ))
})

testthat::test_that("filter_streaming_history function test: checks filtering by date", {
  expect_true(all.equal(
    spotifyviz::clean_stream_his,
    filter_streaming_history(spotifyviz::clean_stream_his, "18.11.04", "18.11.05")
  ))
  expect_true(all.equal(
    spotifyviz::clean_stream_his[56:100],
    filter_streaming_history(spotifyviz::clean_stream_his, "18.11.05", "18.11.10")
  ))
})
