% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ievora.R
\name{ievora}
\alias{ievora}
\alias{row_ievora}
\alias{col_ievora}
\title{iEVORA}
\usage{
row_ievora(x, g, cutT = 0.05, cutBfdr = 0.001)

col_ievora(x, g, cutT = 0.05, cutBfdr = 0.001)
}
\arguments{
\item{x}{numeric matrix}

\item{g}{a vector specifying group membership for each observation of x.
Must contain two unique groups one labeled "1" and another "0".
If the vector is neither numeric nor logical the group appearing first is
labeled "0" and the remaining one as "1".}

\item{cutT}{cutoff threshold for the raw p-value of the t-test step.
(default 0.05)}

\item{cutBfdr}{cutoff threshold for the FDR-corrected p-value of the
Bartlett's test step. (default 0.001)}
}
\value{
a data.frame where each row contains result of the iEVORA algorithm
for the corresponding row/column of x. \cr\cr
Each row contains the following information (in order):\cr
1. obs.0 - number of observations in 0 group\cr
2. obs.1 - number of observations in 1 group\cr
3. obs.tot - number of total observations\cr
4. mean.0 - mean of the 0 group \cr
5. mean.1 - mean of the 1 group \cr
6. mean.diff - mean difference (group1 - group0)\cr
7. var.0 - variance of the 0 group \cr
8. var.1 - variance of the 1 group \cr
9. var.log2.ratio - log ratio of variances log2(var1/var0) \cr
10. statistic.t - t.statistic of the t-test step \cr
11. pvalue.t - raw p-value of the t-test step \cr
12. statistic.bt - chsq.statistic of the bartlett test step \cr
13. pvalue.bt - raw p-value of the Bartlett's test step \cr
14. qvalue.bt - fdr-adjusted p-value of the Bartlett's test step \cr
15. significant - indicator showing if the result was significant \cr
16. rank - rank of the significant results (ordered by t.test p-value)
}
\description{
Epigenetic Variable Outliers for cancer Risk prediction Analysis
}
\details{
Measures differential variability between two groups. The algorithm has
2 steps: detecting difference in variance (Bartlett's test) and detecting
difference in means (t-test). The second step is done to regularize the
variability test which is overly sensitive to single outliers.

By default the result is considered significant if variability test produces
a significant p-value (below selected threshold) after FDR correction and
t-test returns a significant p-value without using the FDR correction.

The algorithm is mainly aimed at large DNA methylation data sets.
}
\examples{
# perform iEVORA on iris dataset for setosa against all other groups
col_ievora(iris[,1:4], iris$Species=="setosa")

}
\references{
Andrew E Teschendorff et.al. DNA methylation outliers in normal
breast tissue identify field defects that are enriched in cancer.
Nature Communications 7, 10478 (2016) doi:10.1038/ncomms10478
}
\seealso{
\code{row_bartlett}, \code{row_t_welch}
}
\author{
Karolis Koncevičius
}
