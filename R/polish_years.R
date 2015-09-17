#' @title polish_years
#'
#' @description Pick and polish the year interval (start and end
#  years) from a time field which is of the form 1800 or 1823-1845 etc.
#'
#' @param x year field (a vector) 
#' @return data.frame with the fields 'start' and 'end'
#'
#' @export
#' 
#' @author Niko Ilomaki \email{niko.ilomaki@@helsinki.fi}
#' @references See citation("bibliographica")
#' 
#' @examples \dontrun{df <- polish_years("1746", "1745-1750")}
#' @keywords utilities
polish_years <- function(x) {

  xorig <- x
  x <- remove_endings(x, "\\.")
  
  start <- x
  start <- gsub("^([0-9]{3,4})\\D[0-9]{3,4}$","\\1",start)
  start <- gsub("^fl. ([0-9]{3,4})\\D[0-9]{3,4}$",NA,start)
  start <- gsub("^n. ([0-9]{4})\\D[0-9]{4}$","\\1",start)
  start <- gsub("^([0-9]{4})\\Dn. [0-9]{4}$","\\1",start)
  start <- gsub("^n. ([0-9]{4})\\Dn. [0-9]{4}$","\\1",start)
  start <- gsub("^s. ([0-9]{4})$","\\1",start)
  start <- gsub("^s. n. ([0-9]{4})$","\\1",start)
  start <- gsub("^k. ([0-9]{4})$",NA,start)
  start <- gsub("^d. ([0-9]{4})$",NA,start)
  start <- gsub("^k. n. ([0-9]{4})$",NA,start)
  start <- gsub("^k. ennen ([0-9]{4})$",NA,start)
  # Skandit pitaa kasitella synonyymisanalistojen tms kautta jotta
  # paastaan eroon niihin liittyvistä virheista paketin kaannossa
  start <- gsub("^k. viimeistään ([0-9]{4})$",NA,start)
  start <- gsub("^k. ([0-9]{4}) jälkeen$",NA,start)
  start <- gsub("^s. n. ([0-9]{4}), k. [0-9]{4}$","\\1",start)
  start <- gsub("^s. ([0-9]{4}), k. n. [0-9]{4}$","\\1",start)
  start <- gsub("^[0-9]{4}\\Dluku$",NA,start)
  start <- gsub("^eli vielä ([0-9]{4})$",NA,start)
  start <- gsub("^[0-9]$",NA,start)
  start <- gsub("^([0-9]{2,3})\\D[0-9]{2,3} e.Kr$","\\-\\1",start)
  start <- gsub("^n. ([0-9]{2,3})\\D[0-9]{2,3} e.Kr$","\\-\\1",start)
  start <- gsub("^([0-9]{2,3})\\D[0-9]{2,3} e. Kr$","\\-\\1",start)
  start <- gsub("^n. ([0-9]{2,3})\\D[0-9]{2,3} e. Kr$","\\-\\1",start)
  start <- gsub("^s. ehkä 1620-luvulla, k. 1694$",NA,start)
  start <- gsub("^s. 1630-luvulla, k. 1684$",NA,start)
  start <- gsub("^s. 1590-luvulla, k. 1651$",NA,start)
  start <- gsub("^k. 1616/1617$",NA,start)
  start <- gsub("^n. 20 e.Kr.-40 j.Kr$","-20",start)
  start <- gsub("^1600/1700\\-luku$",NA,start)
  start <- gsub("^eli 300\\-luvun puolivälissä$",NA,start)
  start <- gsub("^300-l. j. Kr$",NA,start)
  start <- gsub("^k. 1730-luvulla$",NA,start)
  start <- gsub("^k. vähän ennen vuotta 1600$",NA,start)
  start <- gsub("^n. 363-425 j.Kr$",NA,start)
  start <- gsub("^s. 1678, k. 1695 jälkeen$","1678",start)
  start <- gsub("^s. n. 1560, k. ennen 1617$","1560",start)
  start <- gsub("^s. viim. 1638, k. 1681$",NA,start)
  start <- gsub("^toiminta\\-aika 1770\\-luku$",NA,start)
  start <- gsub("^active ", "", start)  
  start_year <- as.numeric(start)

  # pitaisi poistaa paallekkäisyydet
  end <- x
  end <- gsub("^[0-9]{3,4}\\D([0-9]{3,4})$","\\1",end)
  end <- gsub("^fl. [0-9]{3,4}\\D([0-9]{3,4})$",NA,end)
  end <- gsub("^n. [0-9]{4}\\D([0-9]{4})$","\\1",end)
  end <- gsub("^[0-9]{4}\\Dn. ([0-9]{4})$","\\1",end)
  end <- gsub("^n. [0-9]{4}\\Dn. ([0-9]{4})$","\\1",end)
  end <- gsub("^s. ([0-9]{4})$",NA,end)
  end <- gsub("^s. n. ([0-9]{4})$",NA,end)
  end <- gsub("^k. ([0-9]{4})$","\\1",end)
  end <- gsub("^d. ([0-9]{4})$","\\1",end)
  end <- gsub("^k. n. ([0-9]{4})$","\\1",end)
  end <- gsub("^k. ennen ([0-9]{4})$",NA,end)
  end <- gsub("^k. viimeistään ([0-9]{4})$",NA,end)
  end <- gsub("^k. ([0-9]{4}) jälkeen$",NA,end)
  end <- gsub("^s. n. [0-9]{4}, k. ([0-9]{4})$","\\1",end)
  end <- gsub("^s. [0-9]{4}, k. n. ([0-9]{4})$","\\1",end)
  end <- gsub("^[0-9]{4}\\Dluku$",NA,end)
  end <- gsub("^eli vielä ([0-9]{4})$",NA,end)
  end <- gsub("^[0-9]$",NA,end)
  end <- gsub("^[0-9]{2,3}\\D([0-9]{2,3}) e.Kr$","\\-\\1",end)
  end <- gsub("^n. [0-9]{2,3}\\D([0-9]{2,3}) e.Kr$","\\-\\1",end)
  end <- gsub("^[0-9]{2,3}\\D([0-9]{2,3}) e. Kr$","\\-\\1",end)
  end <- gsub("^n. [0-9]{2,3}\\D([0-9]{2,3}) e. Kr$","\\-\\1",end)
  end <- gsub("^s. ehkä 1620-luvulla, k. 1694$","1694",end)
  end <- gsub("^s. 1630-luvulla, k. 1684$","1684",end)
  end <- gsub("^s. 1590-luvulla, k. 1651$","1651",end)
  end <- gsub("^k. 1616/1617$","1616",end)
  end <- gsub("^n. 20 e.Kr.-40 j.Kr$","40",end)
  end <- gsub("^1600/1700\\-luku$",NA,end)
  end <- gsub("^eli 300\\-luvun puolivälissä$",NA,end)
  end <- gsub("^300-l. j. Kr$",NA,end)
  end <- gsub("^k. 1730-luvulla$",NA,end)
  end <- gsub("^k. vähän ennen vuotta 1600$",NA,end)
  end <- gsub("^n. 363-425 j.Kr$",NA,end)
  end <- gsub("^s. 1678, k. 1695 jälkeen$",NA,end)
  end <- gsub("^s. n. 1560, k. ennen 1617$",NA,end)
  end <- gsub("^s. viim. 1638, k. 1681$","1681",end)
  end <- gsub("^toiminta\\-aika 1770\\-luku$",NA,end)
  start <- gsub("^active ", "", start)    
  end_year <- as.numeric(end)

  data.frame(list(original = xorig, start = start_year, end = end_year))

}