#' @title order_gatherings
#' @description Sort gatherings levels 
#' @param x A vector or factor of gathering data
#' @return A factor with ordered gatherings levels
#' @author Leo Lahti \email{leo.lahti@@iki.fi}
#' @references See citation("bibliographica")
#' @examples order_gatherings(factor(c("2fo", "1to", "8vo")))
#' @export
#' @keywords utilities
order_gatherings <- function (x) {

  glevels <- c("1to", "bs", "2long", "2fo", "2small", "4long", "4to", "4small", "6long", "6to", "8long", "8vo", "8small", "12long", "12mo", "16long", "16mo", "18mo", "20to", "24long", "24mo", "32mo", "40mo", "48mo", "64mo", "80mo", "84mo", "NA")
  # Discard: 21to, 40to

  x <- as.character(x)
  x[is.na(x)] <- "NA"

  fails <- unlist(setdiff(unique(x), glevels), use.names = FALSE)
  x[x %in% fails] <- "NA"
  # x[x == "NA"] = NA

  # Order the levels
  xo <- factor(x, levels = glevels)

  xo
}
