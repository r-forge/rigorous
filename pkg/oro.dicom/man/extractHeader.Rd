% Part of the oro.dicom package for R
% Distributed under the BSD license: see oro.dicom/COPYING
%
% $Id: $

\name{extractHeader}
\alias{extractHeader}
\title{Extract Single Field from DICOM Headers}
\description{
  A particular DICOM field is extracted for a collection of DICOM
  headers.
}
\usage{
extractHeader(hdrs, string, numeric = TRUE, names = FALSE,
              inSequence = TRUE)
}
\arguments{
  \item{hdrs}{List object of DICOM headers.}
  \item{string}{DICOM field name.}
  \item{numeric}{Logical; values are converted to numbers when
    \code{TRUE}.}
  \item{names}{Logical; file names are kept with elements of the
    vector.}
  \item{inSequence}{Logical; whether or not to look into SequenceItem
    elements.}
}
\details{
  The DICOM field is extracted from each DICOM header and placed into a
  vector.
}
\value{
  Vector of values from the requested DICOM field.
}
\references{
  Digital Imaging and Communications in Medicine (DICOM)\cr
  \url{http://medical.nema.org}
}
\seealso{
  \code{\link{readDICOM}}
}
\examples{
x <- readDICOMFile(system.file("dcm/Abdo.dcm", package="oro.dicom"))
(seriesDescription <- extractHeader(x$hdr, "SeriesDescription",
                                    numeric=FALSE))
(IOP <- extractHeader(x$hdr, "ImageOrientationPatient", numeric=FALSE))
}
\author{Brandon Whitcher \email{bjw34032@users.sourceforge.net}}
\keyword{misc}
