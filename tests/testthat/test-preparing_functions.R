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

testthat::test_that("Preparing long StreamHisWithPlaylist test",{
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

testthat::test_that("Preparing wide StreamHisWithPlaylist test",{
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

testthat::test_that("make_session_stats function test",{
  p <- make_session_stats(readRDS("DataRDS/CleanStreamHis.rds"))
  expect_equal(dim(p),c(1,4))
  expect_is(p[[1]],"character")
  expect_is(p[[2]],"character")
  expect_is(p[[3]],"integer")
  expect_is(p[[4]],"list")
})

testthat::test_that("make_summary_dt function test",{
  p <- readRDS("DataRDS/CleanStreamHis.rds")
  a <- make_summary_dt(p,"18.11.05","18.11.05")
  b <- make_summary_dt(p,"18.11.03","18.11.06",  as_percentage = TRUE)
  expect_equal(dim(a),dim(b),c(1,5))
  expect_true(a[[1]]<=b[[1]])
  expect_true(a[[3]]<=a[[2]] & a[[2]]<=a[[1]])
  expect_true(b[[3]]<=b[[2]] & b[[2]]<=b[[1]])
  expect_match(b[[4]],"%")
})

testthat::test_that("made_two_users_dt function  test",{
  p <- make_two_users_dt(readRDS("DataRDS/CleanStreamHis.rds"),readRDS("DataRDS/CleanStreamHis2.rds"),"18.11.5")
  expect_equal(dim(p),c(90,3))
  expect_equal(length(unique(p[[3]])),2)
  expect_true(is.POSIXt(p[[1]]))
  expect_true(is.POSIXt(p[[2]]))
  
  
})

testthat::test_that("sessions_intervals function test",{
  a <- readRDS("DataRDS/CleanStreamHis.rds")
  p <- sessions_intervals(a,10)
  q <- sessions_length(a,10)
  expect_equal(sum(p[[3]]),100)
  expect_equal(dim(p),c(3,3))
  expect_equal(sum(p[[2]]),nrow(q))
})

testthat::test_that("sessions_length function test",{
  q <- sessions_length(readRDS("DataRDS/CleanStreamHis.rds"),10)
  expect_equal(dim(q),c(6,2))
  expect_true(class(q[[2]])=="Duration")
  expect_true(class(q[[1]])=="numeric")

})

