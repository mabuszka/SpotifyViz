context("Formatting functions")


testthat::test_that("capitalize function test",{
  expect_equal(capitalize("abc"),"Abc")
  expect_equal(capitalize("Abc"),"Abc")
  expect_equal(capitalize(" abc")," abc")
})


testthat::test_that("from_sec_to_hms function test",{
  expect_true(from_sec_to_hms(50)==" 50 s")
  expect_true(from_sec_to_hms(1220)==" 20 min 20 s")
  expect_true(from_sec_to_hms(1234568)==" 342 h 56 min 8 s")
  expect_true(from_sec_to_hms(0)=="0s")
})


testthat::test_that("session_for_view function test",{
  p <- readRDS("DataRDS/CleanStreamHis.rds")
  a <- session_for_view(p)
  expect_equal(colnames(a),c("Start","Artist name", "Track name", "Time played"))
  expect_equal(nrow(a),nrow(p))
  expect_equal(ncol(a),4)
})
