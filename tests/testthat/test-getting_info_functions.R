context("Getting info functions")

testthat::test_that(
  "how_long_listened function test: check types of data, four values and containing of % sign",
  {
    a <- how_long_listened(spotifyviz::clean_stream_his, "18.11.04", "18.11.07")
    expect_equal(a, " 5 h 13 min 52 s")
    expect_is(a, "character")
    
    a <- how_long_listened(spotifyviz::clean_stream_his,
                           "18.11.04",
                           "18.11.07",
                           as_percentage = TRUE)
    expect_equal(a, "7.27%")
    expect_is(a, "character")
    expect_match(a, "%")
    
    a <- how_long_listened(spotifyviz::clean_stream_his,
                           "18.11.04",
                           "18.11.07",
                           for_viewing = FALSE)
    expect_equal(a, 18832)
    expect_is(a, "numeric")
    
    a <- how_long_listened(
      spotifyviz::clean_stream_his,
      "18.11.04",
      "18.11.07",
      as_percentage = TRUE,
      for_viewing = FALSE
    )
    expect_equal(a, 7.27)
    expect_is(a, "numeric")
  }
)

testthat::test_that(
  "how_many_skipped function test:: check types of data, two values and containing of % sign",
  {
    a <- how_many_skipped(spotifyviz::clean_stream_his, "18.11.04", "18.11.07")
    expect_equal(a, 22)
    expect_is(a, "integer")
    a <- how_many_skipped(spotifyviz::clean_stream_his,
                          "18.11.04",
                          "18.11.07",
                          as_percentage = TRUE)
    expect_equal(a, "22%")
    expect_is(a, "character")
    expect_match(a, "%")
    
  }
)

testthat::test_that("longest_session function test: checks dimensions and number of sessions", {
  p <- longest_session(spotifyviz::clean_stream_his, 10)
  expect_equal(dim(p), c(27, 8))
  expect_equal(length(unique(p[[8]])), 1)
  
})


testthat::test_that("most_played function test: checks four values, class of columns and dimensions", {
  a <- most_played(spotifyviz::clean_stream_his, "track", 10, TRUE)
  b <- most_played(spotifyviz::clean_stream_his, "artist", 10, TRUE)
  c <- most_played(spotifyviz::clean_stream_his, "track", 10, FALSE)
  d <- most_played(spotifyviz::clean_stream_his, "artist", 10, FALSE)
  expect_equal(dim(a), dim(b), c(10, 2))
  expect_equal(dim(c), dim(d), c(10, 2))
  expect_equal(class(a[[1]]), class(b[[1]]), class(c[[1]]), class(d[[1]]), "character")
  expect_equal(class(a[[2]]), class(b[[2]]), class(c[[2]]), class(d[[2]]), "integer")
  expect_equal(a[[1]][1], "Firth Of Fifth - Remastered 2008")
  expect_equal(b[[1]][1], "Genesis")
  expect_equal(c[[1]][1], "Dancing With The Moonlit Knight - Remastered 2008")
  expect_equal(d[[1]][1], "Rise Against")
})

testthat::test_that("most_skipped function test: checks four values, class of columns, dimensions and column names", {
  a <- most_skipped(spotifyviz::clean_stream_his, "track", 10, TRUE)
  b <- most_skipped(spotifyviz::clean_stream_his, "artist", 10, TRUE)
  c <- most_skipped(spotifyviz::clean_stream_his, "track", 10, FALSE)
  d <- most_skipped(spotifyviz::clean_stream_his, "artist", 10, FALSE)
  expect_equal(dim(a), dim(b), c(10, 2))
  expect_equal(dim(c), dim(d), c(10, 2))
  expect_equal(class(a[[1]]), class(b[[1]]), class(c[[1]]), class(d[[1]]), "character")
  expect_equal(class(a[[2]]), class(b[[2]]), class(c[[2]]), class(d[[2]]), "integer")
  expect_equal(a[[1]][1], "Firth Of Fifth - Remastered 2008")
  expect_equal(b[[1]][1], "Genesis")
  expect_equal(c[[1]][1], "Firth Of Fifth - Remastered 2008")
  expect_equal(d[[1]][1], "Genesis")
  expect_equal(colnames(a), c("Track name", "Times skipped"))
  expect_equal(colnames(b), c("Artist name", "Times skipped"))
  expect_equal(colnames(c), c("track_name", "N"))
  expect_equal(colnames(d), c("artist_name", "N"))
})
