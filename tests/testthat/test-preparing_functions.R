context("Preparing functions")



testthat::test_that("StreamingHistory preparing test: checks dimensions, object type and column types",
                    {
                      p <- prepare_streaming_history(spotifyviz::dirty_stream_his)
                      expect_equal(dim(p), c(100, 7))
                      expect_true(is.POSIXt(p[[1]]))
                      expect_is(p[[2]], "character")
                      expect_is(p[[3]], "character")
                      expect_is(p[[4]], "Duration")
                      expect_true(is.POSIXt(p[[5]]))
                      expect_is(p[[6]], "logical")
                      expect_true(is.factor(p[[7]]))
                      expect_is(p, "data.table")
                    })

testthat::test_that(
  "CompleteStreamHis reading and preparing test: checks dimensions, object type and column types",
  {
    p <- complete_streaming_history("DataFromSpotify")
    expect_equal(dim(p), c(100, 7))
    expect_true(is.POSIXt(p[[1]]))
    expect_is(p[[2]], "character")
    expect_is(p[[3]], "character")
    expect_is(p[[4]], "Duration")
    expect_true(is.POSIXt(p[[5]]))
    expect_is(p[[6]], "logical")
    expect_true(is.factor(p[[7]]))
    expect_is(p, "data.table")
  }
)

testthat::test_that(
  "Preparing long StreamHisWithPlaylist test :checks dimensions, object type,
  column types and one of  many data table value",
  {
    p <- str_his_with_playlists_long(spotifyviz::clean_playlist,
                                     spotifyviz::clean_stream_his)
    expect_equal(dim(p), c(100, 8))
    expect_is(p[[1]], "character")
    expect_is(p[[2]], "character")
    expect_is(p[[3]], "character")
    expect_true(is.POSIXt(p[[4]]))
    expect_is(p[[5]], "Duration")
    expect_true(is.POSIXt(p[[6]]))
    expect_is(p[[7]], "logical")
    expect_true(is.factor(p[[8]]))
    expect_is(p, "data.table")
    expect_equal(p[[1]][12], "Urodzinowa playlista")
  }
)

testthat::test_that("Preparing wide StreamHisWithPlaylist test::checks dimensions, object type,
  column types and two of many data table value", {
  p <- str_his_with_playlists_wide(spotifyviz::clean_playlist,
                                spotifyviz::clean_stream_his)
  expect_equal(dim(p), c(100, 9))
  expect_true(is.POSIXt(p[[1]]))
  expect_is(p[[2]], "character")
  expect_is(p[[3]], "character")
  expect_is(p[[4]], "Duration")
  expect_true(is.POSIXt(p[[5]]))
  expect_is(p[[6]], "logical")
  expect_true(is.factor(p[[7]]))
  expect_is(p[[8]], "logical")
  expect_is(p[[9]], "logical")
  expect_true(p[[8]][30])
  expect_true(p[[9]][30])
  expect_is(p, "data.table")
})

testthat::test_that("make_session_stats function test :checks dimensions and column types" , {
  p <- make_session_stats(spotifyviz::clean_stream_his)
  expect_equal(dim(p), c(1, 4))
  expect_is(p[[1]], "character")
  expect_is(p[[2]], "character")
  expect_is(p[[3]], "integer")
  expect_is(p[[4]], "list")
})

testthat::test_that(
  "make_summary_dt function test: :checks dimensions, compare values and containing of % sign",
  {
    a <-
      make_summary_dt(spotifyviz::clean_stream_his, "18.11.05", "18.11.05")
    b <- make_summary_dt(spotifyviz::clean_stream_his,
                         "18.11.03",
                         "18.11.06",
                         as_percentage = TRUE)
    expect_equal(dim(a), dim(b), c(1, 5))
    expect_true(a[[1]] <= b[[1]])
    expect_true(a[[3]] <= a[[2]] & a[[2]] <= a[[1]])
    expect_true(b[[3]] <= b[[2]] & b[[2]] <= b[[1]])
    expect_match(b[[4]], "%")
  }
)

testthat::test_that("made_two_users_dt function  test: :checks dimensions, number of sessions,
  column types", {
  p <- make_two_users_dt(spotifyviz::clean_stream_his,
                         spotifyviz::clean_stream_his,
                         "18.11.5")
  expect_equal(dim(p), c(90, 3))
  expect_equal(length(unique(p[[3]])), 2)
  expect_true(is.POSIXt(p[[1]]))
  expect_true(is.POSIXt(p[[2]]))
  
  
})


testthat::test_that(
  "sessions_intervals function test: checks dimensions, sums of percents and sum of sessions",
  {
    p <- sessions_intervals(spotifyviz::clean_stream_his, 10)
    q <- sessions_length(spotifyviz::clean_stream_his, 10)
    expect_equal(sum(p[[3]]), 100)
    expect_equal(dim(p), c(3, 3))
    expect_equal(sum(p[[2]]), nrow(q))
  }
)

testthat::test_that("sessions_length function test: checks data table columns type and dimensions ", {
  q <- sessions_length(spotifyviz::clean_stream_his, 10)
  expect_equal(dim(q), c(6, 2))
  expect_true(class(q[[2]]) == "Duration")
  expect_true(class(q[[1]]) == "numeric")
  
})
