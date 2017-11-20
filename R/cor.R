#' correlation
#'
#' Performs a correlation test on each row of a the input matrix.
#'
#' Functions to perform various correlation tests for rows of matrices.
#' Main arguments and results were intentionally matched to the \code{cor.test()}
#' function from default stats package.
#'
#' \code{cor_pearson()} - test for Pearson correlation coefficient.
#' Same as \code{cor.test(x,y,method="pearson")}
#'
#' @name cortest
#'
#' @param x numeric matrix.
#' @param y numeric matrix for the second group of observations.
#' @param alternative alternative hypothesis to use for each row of x.
#' A single string or a vector of length nrow(x).
#' Must be one of "two.sided" (default), "greater" or "less".
#' @param conf.level confidence levels used for the confidence intervals.
#' A single number or a numeric vector of length nrow(x).
#' All values must be in the range of [0;1].
#'
#' @return a data.frame where each row contains the results of a correlation
#' test performed on the corresponding row of x. The columns will vary
#' depending on the type of test performed.
#'
#' @seealso \code{cor.test()}
#'
#' @examples
#' X <- t(iris[iris$Species=="setosa",1:4])
#' Y <- t(iris[iris$Species=="virginica",1:4])
#' cor_pearson(X, Y)
#'
#' @author Karolis Koncevičius
cor_pearson <- function(x, y, alternative="two.sided", conf.level=0.95) {
  force(x)
  force(y)

  if(is.vector(x))
    x <- matrix(x, nrow=1)
  if(is.vector(y))
    y <- matrix(y, nrow=1)

  if(is.data.frame(x) && all(sapply(x, is.numeric)))
    x <- data.matrix(x)
  if(is.data.frame(y) && all(sapply(y, is.numeric)))
    y <- data.matrix(y)

  assert_numeric_mat_or_vec(x)
  assert_numeric_mat_or_vec(y)
  assert_equal_nrow(x, y)
  assert_equal_ncol(x, y)

  if(length(alternative)==1)
    alternative <- rep(alternative, length.out=nrow(x))
  assert_character_vec_length(alternative, 1, nrow(x))

  choices <- c("two.sided", "less", "greater")
  alternative <- choices[pmatch(alternative, choices, duplicates.ok=TRUE)]
  assert_all_in_set(alternative, choices)

  if(length(conf.level)==1)
    conf.level <- rep(conf.level, length.out=nrow(x))
  assert_numeric_vec_length(conf.level, 1, nrow(x))
  assert_all_in_range(conf.level, 0, 1)

  mu <- 0 # can't be changed because different test should be used in that case.

  x[is.na(y)] <- NA
  y[is.na(x)] <- NA

  ns <- matrixStats::rowCounts(!is.na(x))

  mx <- rowMeans(x, na.rm=TRUE)
  my <- rowMeans(y, na.rm=TRUE)
  sx <- sqrt(rowSums((x-mx)^2, na.rm=TRUE) / (ns-1))
  sy <- sqrt(rowSums((y-my)^2, na.rm=TRUE) / (ns-1))

  rs  <- rowSums((x-mx)*(y-my), na.rm=TRUE) / (sx*sy*(ns-1))
  dfs <- ns-2

  pres <- do_pearson(rs, dfs, alternative, conf.level)

  w1 <- ns < 3
  showWarning(w1, 'had less than 3 complete observations')

  w2 <- !w1 & sx==0
  showWarning(w2, 'had zero standard deviation in x')

  w3 <- !w1 & sy==0
  showWarning(w3, 'had zero standard deviation in y')

  w4 <- !w2 & !w3 & ns == 3
  showWarning(w4, 'had exactly 3 complete observations: no confidence intervals produced')

  w5 <- !w1 & abs(rs)==1
  showWarning(w5, 'had essentially perfect fit: results might be unreliable for small sample sizes')

  pres[w4, 3:4] <- NA
  pres[w1 | w2 | w3,] <- NA
  rs[w1 | w2 | w3] <- NA

  rnames <- rownames(x)
  if(!is.null(rnames)) rnames <- make.unique(rnames)
  data.frame(obs.complete=ns, correlation=rs, t.statistic=pres[,1],
             p.value=pres[,2], ci.low=pres[,3], ci.high=pres[,4], df=dfs,
             mean.null=mu, conf.level=conf.level, alternative=alternative,
             stringsAsFactors=FALSE, row.names=rnames
             )
}
