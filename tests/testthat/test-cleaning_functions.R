context("Cleaning functions")

testthat::test_that("continuous_listening test",{
  p<-readRDS("DataRDS/CleanStreamHis.rds")
  expect_equal(continuous_listening(p,10)[[8]][1:30],c(rep.int(1,29),2))
  expect_equal(continuous_listening(p[30],10)[[8]],1)
})

testthat::test_that("capitalize function test",{
  expect_equal(capitalize("abc"),"Abc")
  expect_equal(capitalize("Abc"),"Abc")
  expect_equal(capitalize(" abc")," abc")
})

testthat::test_that("filter_search_queries function test",{
  p<-readRDS("DataRDS/CleanSearchQueries.rds")
  expect_true(all.equal(p,filter_search_queries(p,"19.09.10","19.10.10")))
  expect_true(all.equal(p[1:3],filter_search_queries(p,"19.09.30","19.09.30")))
})

testthat::test_that("filter_streaming_history function test",{
  p<-readRDS("DataRDS/CleanStreamHis.rds")
  expect_true(all.equal(p,filter_streaming_history(p,"18.11.04","18.11.05")))
  expect_true(all.equal(p[56:100],filter_streaming_history(p,"18.11.05","18.11.10")))
})