% Part of the oro.dicom package for R
% Distributed under the BSD license: see oro.dicom/COPYING
%
% $Id: $

\name{Create}
\alias{create3D}
\alias{create4D}
\title{Create Arrays from DICOM Headers/Images}
\description{
  A DICOM list structure is used to produce a multi-dimensional array
  representing a single acquisition of medical imaging data.
}
\usage{
create3D(dcm, mode = "integer", transpose = TRUE, pixelData = TRUE,
         mosaic = FALSE, mosaicXY = NULL, sequence = FALSE)
create4D(dcm, mode = "integer", transpose = TRUE, pixelData = TRUE,
         mosaic = FALSE, mosaicXY = NULL, nslices = NULL,
         ntimes = NULL, instance = TRUE, sequence = FALSE)
}
\arguments{
  \item{dcm}{is the DICOM list structure (if \code{pixelData} =
    \code{TRUE}) or the DICOM header information (if \code{pixelData} =
    \code{FALSE}).}
  \item{mode}{is a valid character string for \code{storage.mode}.}
  \item{transpose}{is available in order to switch the definition of
    rows and columns from DICOM (default = \code{TRUE}.}
  \item{pixelData}{is a logical variable (default = \code{TRUE}) that is
    associated with the DICOM image data being pre-loaded.}
  \item{mosaic}{is a logical variable (default = \code{FALSE}) to denote
    storage of the data in Siemens \sQuote{Mosaic} format.}
  \item{mosaicXY}{is a vector of length two that provides the (x,y)
    dimensions of the individual images.  Default behavior is to use the
    AcquisitonMatrix to determine the (x,y) values.}
  \item{sequence}{is a logical variable (default = \code{FALSE}) on
    whether to look in SequenceItem entries for DICOM header
    information.}
  \item{nslices}{is the third dimension of the array.  Attempts are made
    to determine this number from the DICOM data.}
  \item{ntimes}{is the fourth dimension of the array.  Attempts are made
    to determine this number from the DICOM data.}
  \item{instance}{is a logical variable (default = \code{TRUE}) that
    determines whether or not to access the \code{InstanceNumber} field
    in the DICOM header to help order the slices.}
}
\value{
  Multi-dimensional array of medical imaging data.
}
%\details{}
\references{
  Digital Imaging and Communications in Medicine (DICOM)\cr
  \url{http://medical.nema.org}
}
\seealso{
  \code{\link{array}}, \code{\link{readDICOM}},
  \code{\link{storage.mode}}
}
\examples{
## pixelData = TRUE
## The DICOM image data are read from readDICOM()
\dontrun{
dcmList <- readDICOM(system.file("hk-40", package="oro.dicom"))
}
load(system.file("hk-40/hk40.RData", package="oro.dicom"))
dcmList <- hk40
dcmImage <- create3D(dcmList)
image(dcmImage[,,1], col=grey(0:64/64), axes=FALSE, xlab="", ylab="",
      main=paste("First Slice from HK-40"))
imagePositionPatient <- attributes(dcmImage)$ipp
dSL <- abs(diff(imagePositionPatient[,3]))
plot(dSL, ylim=range(range(dSL) * 1.5, 0, 10), xlab="Image", ylab="mm",
     main="Difference in Slice Location")

\dontrun{
## pixelData = FALSE
## The DICOM image data are read from create3D()
## This may save on memory for large batches of DICOM data
dcmList <- readDICOM(system.file("hk-40", package="oro.dicom"),
                     pixelData=FALSE)
dcmImage <- create3D(dcmList, pixelData=FALSE)
image(dcmImage[,,1], col=grey(0:64/64), axes=FALSE, xlab="", ylab="",
      main=paste("First Slice from HK-40 (again)"))
}
## mosaic = TRUE
mosaicFile <- system.file("dcm/MR-sonata-3D-as-Tile.dcm", package="oro.dicom")
dcm <- readDICOMFile(mosaicFile)
image(t(dcm$img), col=grey(0:64/64), axes=FALSE, xlab="", ylab="",
      main="Siemens MOSAIC")
dcmImage <- create3D(dcm, mode="integer", mosaic=TRUE)
z <- trunc(dim(dcmImage)[3]/2)
image(dcmImage[,,z], col=grey(0:64/64), axes=FALSE, xlab="", ylab="",
      main=paste("Slice", z, "from Siemens MOSAIC"))
}
\author{Brandon Whitcher \email{bjw34032@users.sourceforge.net}}
%\keyword{}
