context("Formatting functions")


testthat::test_that("capitalize function test: check function effect for three different examples",
                    {
                      expect_equal(capitalize("abc"), "Abc")
                      expect_equal(capitalize("Abc"), "Abc")
                      expect_equal(capitalize(" abc"), " abc")
                    })


testthat::test_that("from_sec_to_hms function test:check function effect for four different examples",
                    {
                      expect_true(from_sec_to_hms(50) == " 50 s")
                      expect_true(from_sec_to_hms(1220) == " 20 min 20 s")
                      expect_true(from_sec_to_hms(1234568) == " 342 h 56 min 8 s")
                      expect_true(from_sec_to_hms(0) == "0s")
                    })


testthat::test_that("session_for_view function test: check column names and dimensions ", {
  a <- session_for_view(spotifyviz::clean_stream_his)
  expect_equal(colnames(a),
               c("Start", "Artist name", "Track name", "Time played"))
  expect_equal(nrow(a), nrow(spotifyviz::clean_stream_his))
  expect_equal(ncol(a), 4)
})
