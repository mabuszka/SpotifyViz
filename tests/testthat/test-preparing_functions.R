context("Preparing functions")



testthat::test_that("StreamingHistory preparing test",{
  p <- prepare_streaming_history(readRDS("DataRDS/DirtyStreamHis.rds"))
  expect_equal(dim(p),c(100,7))
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
  
  p <- complete_streaming_history("DataFromSpotify")
  expect_equal(dim(p),c(100,7))
  expect_true(is.POSIXt(p[[1]]))
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_is(p[[4]],"Duration")
  expect_true(is.POSIXt(p[[5]]))
  expect_is(p[[6]],"logical")
  expect_true(is.factor(p[[7]]))
  expect_is(p,"data.table")
})

testthat::test_that("preparing long StreamHisWithPlaylist test",{
  p <- str_his_with_playlists_long(readRDS("DataRDS/CleanPlaylist.rds"),readRDS("DataRDS/CleanStreamHis.rds"))
  expect_equal(dim(p),c(100,8))
  expect_is(p[[1]],"character")
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_true(is.POSIXt(p[[4]]))
  expect_is(p[[5]],"Duration")
  expect_true(is.POSIXt(p[[6]]))
  expect_is(p[[7]],"logical")
  expect_true(is.factor(p[[8]]))
  expect_is(p,"data.table")
  expect_equal(p[[1]][12],"Urodzinowa playlista")
})

testthat::test_that("preparing wide StreamHisWithPlaylist test",{
  p <- str_his_with_playlists_wide(readRDS("DataRDS/CleanPlaylist.rds"),readRDS("DataRDS/CleanStreamHis.rds"))
  expect_equal(dim(p),c(100,9))
  expect_true(is.POSIXt(p[[1]]))
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"character")
  expect_is(p[[4]],"Duration")
  expect_true(is.POSIXt(p[[5]]))
  expect_is(p[[6]],"logical")
  expect_true(is.factor(p[[7]]))
  expect_is(p[[8]],"logical")
  expect_is(p[[9]],"logical")
  expect_true(p[[8]][30])
  expect_true(p[[9]][30])
  expect_is(p,"data.table")
})



