\name{samplesMetricMap}
\alias{samplesMetricMap}
\alias{samplesMetricMap,list-method}
\title{Plot a Grid of Sample Error Rates or Accuracies}
\description{A grid of coloured tiles is drawn. There is one column for each sample
and one row for each classification result.
       }
\usage{
  \S4method{samplesMetricMap}{list}(results,
                   comparison = c("classificationName", "datasetName", "selectionName", "validation"),
                   metric = c("error", "accuracy"),
                   metricColours = list(c("#0000FF", "#3F3FFF", "#7F7FFF", "#BFBFFF", "#FFFFFF"),
                                        c("#FF0000", "#FF3F3F", "#FF7F7F", "#FFBFBF", "#FFFFFF")),
                   classColours = c("blue", "red"), fontSizes = c(24, 16, 12, 12, 12),
                   mapHeight = 4, title = "Error Comparison", showLegends = TRUE, xAxisLabel = "Sample Name", 
                   showXtickLabels = TRUE, showYtickLabels = TRUE, yAxisLabel = "Analysis",
                   legendSize = grid::unit(1, "lines"), plot = TRUE)
}
\arguments{
  \item{results}{A list of \code{\link{ClassifyResult}} objects.}
  \item{comparison}{The aspect of the experimental design to compare.}
  \item{metric}{The sample-wise metric to calculate and plot.}
  \item{metricColours}{A vector of colours for metric levels.}
  \item{classColours}{Either a vector of colours for class levels if both classes should
                      have same colour, or a list of length 2, with each component
                      being a vector of the same length. The vector has the colour gradient
                      for each class.}
  \item{fontSizes}{A vector of length 5. The first number is the size of the title.
                   The second number is the size of the axes titles. The third number is
                   the size of the axes values. The fourth number is the size of the
                   legends' titles. The fifth number is the font size of the legend labels.}
  \item{mapHeight}{Height of the map, relative to the height of the class colour bar.}     
  \item{title}{The title to place above the plot.}     
  \item{showLegends}{Logical. IF FALSE, the legend is not drawn.}
  \item{xAxisLabel}{The name plotted for the x-axis. NULL suppresses label.} 
  \item{showXtickLabels}{Logical. IF FALSE, the x-axis labels are hidden.}
  \item{showYtickLabels}{Logical. IF FALSE, the y-axis labels are hidden.}
  \item{yAxisLabel}{The name plotted for the y-axis. NULL suppresses label.}
  \item{legendSize}{The size of the boxes in the legends.}
  \item{plot}{Logical. IF \code{TRUE}, a plot is produced on the current graphics device.}
}
\details{
The names of \code{results} determine the row names that will be in the plot.
The length of \code{metricColours} determines how many bins the metric values will
be discretised to.
}
\value{
  A plot is produced and a grob is returned that can be saved to a graphics device.
}
\author{Dario Strbenac}

\examples{
  predicted <- data.frame(sample = sample(10, 100, replace = TRUE),
                          label = rep(c("Healthy", "Cancer"), each = 50))
  actual <- factor(rep(c("Healthy", "Cancer"), each = 5))
  result1 <- ClassifyResult("Example", "Differential Expression", "t-test",
                            LETTERS[1:10], LETTERS[10:1], list(1:100), list(sample(10, 10)),
                            list(predicted), actual, list("resampleFold", 100, 5))
  predicted[, "label"] <- sample(predicted[, "label"])
  result2 <- ClassifyResult("Example", "Differential Variability", "F-test",
                            LETTERS[1:10], LETTERS[10:1], list(1:100), list(sample(10, 10)),
                            list(predicted), actual, validation = list("leave", 1))
  wholePlot <- samplesMetricMap(list(Gene = result1, Protein = result2))
  # if(require(ggplot2))
    # ggsave("wholePlot.png", wholePlot)
}
