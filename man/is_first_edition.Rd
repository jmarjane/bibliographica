% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_first_edition.R
\name{is_first_edition}
\alias{is_first_edition}
\title{First Edition Identification}
\usage{
is_first_edition(df)
}
\arguments{
\item{df}{data.frame with the fields: author, title, publication_year}
}
\value{
Logical vector indicating the potential first editions
}
\description{
Identify potential first editions
}
\details{
Identifies unique title-author combinations and marks the earliest occurrence as first edition.
}
\examples{
\dontrun{fed <- is_first_edition(df)}
}
\references{
See citation("bibliographica")
}
\author{
Leo Lahti \email{leo.lahti@iki.fi}
}
\keyword{utilities}
