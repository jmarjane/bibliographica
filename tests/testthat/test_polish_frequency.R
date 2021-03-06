context("Publication frequency")

test_that("polish_publication_frequency for English works correctly", {

  ### English
  expect_equal(as.character(polish_publication_frequency("twice per year")$freq), "Two per Year")
  expect_equal(polish_publication_frequency("twice per year")$annual, 2)
  expect_equal(as.character(polish_publication_frequency("daily, except sundays")$freq), "Six per Week")
  expect_equal(as.character(polish_publication_frequency("daily (except sundays)")$freq), "Six per Week")
  expect_equal(as.character(polish_publication_frequency("daily (except weekends)")$freq), "Five per Week")    
  expect_equal(as.character(polish_publication_frequency("daily, except weekends")$freq), "Five per Week")
  expect_equal(as.character(polish_publication_frequency("daily")$freq), "Daily")
  expect_equal(as.character(polish_publication_frequency("weekly")$freq), "Weekly")
  expect_equal(as.character(polish_publication_frequency("Monthly")$freq), "Monthly")

})


test_that("polish_publication_frequency for Finnish works correctly", {

  ### Finnish					
  expect_equal(as.character(polish_publication_frequency("Kaksi kertaa vuodessa.")$freq), "Two per Year")
  expect_equal(polish_publication_frequency("Kaksi kertaa vuodessa.")$annual, 2)
  expect_equal(polish_publication_frequency("yksi kertaa vuodessa.")$annual, 1)
  expect_equal(polish_publication_frequency("yksi kerta vuodessa")$annual, 1)    
  expect_equal(polish_publication_frequency("1-2 kertaa kuussa")$annual, 18)
  expect_equal(polish_publication_frequency("yhdestä-kahteen kertaa kuussa")$annual, 18)
  expect_equal(polish_publication_frequency("Kerran-kaksi kuukaudessa")$annual, 18)    
  expect_equal(polish_publication_frequency("1 numeroa viikossa")$annual, 52)
  expect_equal(polish_publication_frequency("1 numero viikossa")$annual, 52)
  expect_equal(polish_publication_frequency("2 numeroa viikossa")$annual, 104)
  expect_equal(polish_publication_frequency("2 numero viikossa")$annual, 104)        
  expect_equal(polish_publication_frequency("kerran kuussa")$annual, 12)
  expect_equal(polish_publication_frequency("1-2 kuussa")$annual, 18)
  expect_equal(polish_publication_frequency("yhdestä-kahteen kuussa")$annual, 18)
  expect_equal(polish_publication_frequency("yhdestä kahteen kertaa kuussa")$annual, 18)  
  expect_equal(polish_publication_frequency("kahdesta-neljaan kertaa kuussa")$annual, 36)  

  expect_true(is.na(polish_publication_frequency("Kahdeksan numeroa.")$annual))
  expect_equal(as.character(polish_publication_frequency("Kahdeksan numeroa.")$freq), "Irregular")

  expect_equal(polish_publication_frequency("paivittain")$annual, 365)
  expect_equal(polish_publication_frequency("viikottain")$annual, 52)
  expect_equal(polish_publication_frequency("kuukausittain")$annual, 12)
  expect_equal(polish_publication_frequency("vuosittain")$annual, 1)

  expect_equal(polish_publication_frequency("joka toinen vuosi")$annual, 0.5)
  expect_equal(polish_publication_frequency("joka kolmas vuosi")$annual, 1/3)

  expect_equal(polish_publication_frequency("kerran kahdessa kuukaudessa")$annual, 6)
  expect_equal(polish_publication_frequency("kerran kahdessa vuodessa")$annual, .5)

  expect_true(is.na(polish_publication_frequency("kertajulkaisu")$annual))
  expect_true(is.na(polish_publication_frequency("vaihtelee")$annual))

  expect_equal(as.character(polish_publication_frequency("vaihtelee")$freq), "Irregular")
  expect_equal(as.character(polish_publication_frequency("ilmestynyt vain kerran")$freq), "Single")

})


test_that("polish_publication_frequency for Swedish works correctly", {

  ### Swedish
  
  expect_equal(as.character(polish_publication_frequency("1 nr/manad med sommaruppehall")$freq), "Monthly")
  expect_equal(as.character(polish_publication_frequency("1 nr/manaden med sommaruppehall")$freq), "Monthly")
  expect_equal(as.character(polish_publication_frequency("vart tredje ar")$freq), "Every three Years")
  expect_equal(as.character(polish_publication_frequency("Varje vecka")$freq), "Weekly")
  expect_equal(as.character(polish_publication_frequency("varannan månad")$freq), "Every two Months")
  expect_equal(as.character(polish_publication_frequency("1 nr/varannan månad")$freq), "Every two Months")

  expect_equal(as.character(polish_publication_frequency("4 h./år")$freq), "Every three Months")
  expect_equal(as.character(polish_publication_frequency("4 hft/år")$freq), "Every three Months")
  expect_equal(as.character(polish_publication_frequency("Varje vecka")$freq), "Weekly")
  expect_equal(polish_publication_frequency("Vartannat eller vart trejde år")$annual, 2.5)
  expect_equal(polish_publication_frequency("Vart tredje år-1 nr/år")$annual, 0.5)
  expect_equal(polish_publication_frequency("Vart tredje till vart fjärde år")$annual, 1/3.5)

  expect_equal(as.character(polish_publication_frequency("Tidigare 1 nr vart tredje år, nu 1 nr/år")$freq), "Irregular")
  expect_equal(polish_publication_frequency("16 nr/termin")$annual, 32)  

})
