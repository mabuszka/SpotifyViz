context("Preparing functions")



testthat::test_that("StreamingHistory preparing test",{
  
  streaming_history<-readRDS("DirtyStreamHis.rds")
  p<-prepare_streaming_history(streaming_history)
  expect_equal(dim(p),c(30,7))
  expect_true(is.POSIXt(p[[1]]))
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_is(p[[4]],"Duration")
  expect_true(is.POSIXt(p[[5]]))
  expect_is(p[[6]],"logical")
  expect_true(is.factor(p[[7]]))
  expect_is(p,"data.table")
})

testthat::test_that("CompleteStreamHis reading and preparing test",{
  
  p<-complete_streaming_history(".")
  expect_equal(dim(p),c(30,7))
  expect_true(is.POSIXt(p[[1]]))
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_is(p[[4]],"Duration")
  expect_true(is.POSIXt(p[[5]]))
  expect_is(p[[6]],"logical")
  expect_true(is.factor(p[[7]]))
  expect_is(p,"data.table")
})



