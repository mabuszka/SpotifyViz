context("Compare function")

testthat::test_that(
  "compare_history  test: checks data table columns type, dimensions and compare number of rows",
  {
    a <- compare_history(spotifyviz::clean_stream_his,
                      spotifyviz::clean_stream_his2)
    b <- compare_history(spotifyviz::clean_stream_his,
                      spotifyviz::clean_stream_his2,
                      TRUE)
    expect_equal(dim(a), c(28, 1))
    expect_equal(dim(b), c(76, 2))
    expect_true(nrow(b) >= nrow(a))
    expect_is(a[[1]], "character")
    expect_is(b[[1]], "character")
    expect_is(b[[2]], "character")
    
    
  }
)
