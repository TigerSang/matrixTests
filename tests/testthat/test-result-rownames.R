context("Result rownames")

test_that("when no row-names in the input - numbers are added", {
  X <- matrix(rnorm(100), nrow=10)
  Y <- matrix(rnorm(100), nrow=10)
  grp <- sample(c(1,0), 10, replace=TRUE)
  rnames <- as.character(1:nrow(X))
  expect_equal(rownames(row_t_onesample(x=X)), rnames)
  expect_equal(rownames(row_t_equalvar(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_welch(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_paired(x=X, y=Y)), rnames)
  expect_equal(rownames(row_oneway_equalvar(x=X, g=grp)), rnames)
  expect_equal(rownames(row_oneway_welch(x=X, g=grp)), rnames)
  expect_equal(rownames(row_kruskalwallis(x=X, g=grp)), rnames)
  expect_equal(rownames(row_bartlett(x=X, g=grp)), rnames)
  expect_equal(rownames(row_cor_pearson(x=X, y=Y)), rnames)
  expect_equal(rownames(row_ievora(x=X, g=grp)), rnames)
})


test_that("when X doesn't have rownames - names from Y or groups are not used", {
  X <- matrix(rnorm(100), nrow=10)
  Y <- matrix(rnorm(100), nrow=10)
  grp <- sample(c(1,0), 10, replace=TRUE)
  rownames(Y) <- LETTERS[1:10]
  names(grp) <- LETTERS[1:10]
  rnames <- as.character(1:nrow(X))
  expect_equal(rownames(row_t_onesample(x=X)), rnames)
  expect_equal(rownames(row_t_equalvar(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_welch(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_paired(x=X, y=Y)), rnames)
  expect_equal(rownames(row_oneway_equalvar(x=X, g=grp)), rnames)
  expect_equal(rownames(row_oneway_welch(x=X, g=grp)), rnames)
  expect_equal(rownames(row_kruskalwallis(x=X, g=grp)), rnames)
  expect_equal(rownames(row_bartlett(x=X, g=grp)), rnames)
  expect_equal(rownames(row_cor_pearson(x=X, y=Y)), rnames)
  expect_equal(rownames(row_ievora(x=X, g=grp)), rnames)
})


test_that("when row-names are specified - they are preserved", {
  # matrix case
  X <- matrix(rnorm(100), nrow=10)
  rownames(X) <- LETTERS[1:10]
  Y <- matrix(rnorm(100), nrow=10)
  grp <- sample(c(1,0), 10, replace=TRUE)
  rnames <- rownames(X)
  expect_equal(rownames(row_t_onesample(x=X)), rnames)
  expect_equal(rownames(row_t_equalvar(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_welch(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_paired(x=X, y=Y)), rnames)
  expect_equal(rownames(row_oneway_equalvar(x=X, g=grp)), rnames)
  expect_equal(rownames(row_oneway_welch(x=X, g=grp)), rnames)
  expect_equal(rownames(row_kruskalwallis(x=X, g=grp)), rnames)
  expect_equal(rownames(row_bartlett(x=X, g=grp)), rnames)
  expect_equal(rownames(row_cor_pearson(x=X, y=Y)), rnames)
  expect_equal(rownames(row_ievora(x=X, g=grp)), rnames)
  # data.frame case
  X <- as.data.frame(X)
  Y <- as.data.frame(Y)
  rnames <- rownames(X)
  expect_equal(rownames(row_t_onesample(x=X)), rnames)
  expect_equal(rownames(row_t_equalvar(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_welch(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_paired(x=X, y=Y)), rnames)
  expect_equal(rownames(row_oneway_equalvar(x=X, g=grp)), rnames)
  expect_equal(rownames(row_oneway_welch(x=X, g=grp)), rnames)
  expect_equal(rownames(row_kruskalwallis(x=X, g=grp)), rnames)
  expect_equal(rownames(row_bartlett(x=X, g=grp)), rnames)
  expect_equal(rownames(row_cor_pearson(x=X, y=Y)), rnames)
  expect_equal(rownames(row_ievora(x=X, g=grp)), rnames)
})


test_that("when row-names are duplicated - they are modified to be unique", {
  X <- matrix(rnorm(100), nrow=10)
  Y <- matrix(rnorm(100), nrow=10)
  grp <- sample(c(1,0), 10, replace=TRUE)
  rownames(X) <- c(rep("A",5), rep("B", 5))
  rnames <- make.unique(rownames(X))
  expect_equal(rownames(row_t_onesample(x=X)), rnames)
  expect_equal(rownames(row_t_equalvar(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_welch(x=X, y=Y)), rnames)
  expect_equal(rownames(row_t_paired(x=X, y=Y)), rnames)
  expect_equal(rownames(row_oneway_equalvar(x=X, g=grp)), rnames)
  expect_equal(rownames(row_oneway_welch(x=X, g=grp)), rnames)
  expect_equal(rownames(row_kruskalwallis(x=X, g=grp)), rnames)
  expect_equal(rownames(row_bartlett(x=X, g=grp)), rnames)
  expect_equal(rownames(row_cor_pearson(x=X, y=Y)), rnames)
  expect_equal(rownames(row_ievora(x=X, g=grp)), rnames)
})

