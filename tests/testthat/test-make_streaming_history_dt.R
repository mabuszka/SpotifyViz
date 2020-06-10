context("Reading JSON Files")

testthat::test_that("StreamingHistory reading test",{
  p<-make_streaming_history_dt(".")
  expect_equal(dim(p),c(30,4))
  expect_is(p[[1]],"character")
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_is(p[[4]],"integer")
  expect_is(p,"data.table")
})

