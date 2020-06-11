context("Compare function")

testthat::test_that("compare_history  test",{
  a <- compare_history(readRDS("DataRDS/CleanStreamHis.rds"),readRDS("DataRDS/CleanStreamHis2.rds"))
  b <- compare_history(readRDS("DataRDS/CleanStreamHis.rds"),readRDS("DataRDS/CleanStreamHis2.rds"), TRUE)
  expect_equal(dim(a),c(28,1))
  expect_equal(dim(b),c(76,2))
  expect_true(nrow(b)>=nrow(a))
  expect_is(a[[1]],"character")
  expect_is(b[[1]],"character")
  expect_is(b[[2]],"character")
  
  
})

