## ---- test-simStateSpace-sim-ssm-lin-growth
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    message(text)
    # prepare parameters
    set.seed(42)
    n <- 10
    mu0 <- c(0.615, 1.006)
    sigma0 <- matrix(
      data = c(
        1.932,
        0.618,
        0.618,
        0.587
      ),
      nrow = 2
    )
    theta <- 0.6
    time <- 10
    gamma_y <- matrix(data = 0.10, nrow = 1, ncol = 2)
    gamma_eta <- matrix(data = 0.10, nrow = 2, ncol = 2)
    x <- lapply(
      X = seq_len(n),
      FUN = function(i) {
        return(
          matrix(
            data = rnorm(n = 2 * time),
            ncol = 2
          )
        )
      }
    )

    # Type 0
    ssm <- simStateSpace::SimSSMLinGrowth(
      n = n,
      mu0 = mu0,
      sigma0 = sigma0,
      theta = theta,
      type = 0,
      time = time
    )

    as.data.frame.simstatespace(ssm, eta = TRUE)
    as.data.frame.simstatespace(ssm, eta = FALSE)
    as.data.frame.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.data.frame.simstatespace(ssm, eta = FALSE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE)
    as.matrix.simstatespace(ssm, eta = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = FALSE, long = FALSE)
    print.simstatespace(ssm)
    plot.simstatespace(ssm, id = 1:3, time = 0:4)
    plot.simstatespace(ssm, eta = TRUE)

    # Type 1
    ssm <- simStateSpace::SimSSMLinGrowth(
      n = n,
      mu0 = mu0,
      sigma0 = sigma0,
      theta = theta,
      gamma_eta = gamma_eta,
      x = x,
      type = 1,
      time = time
    )

    as.data.frame.simstatespace(ssm, eta = TRUE)
    as.data.frame.simstatespace(ssm, eta = FALSE)
    as.data.frame.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.data.frame.simstatespace(ssm, eta = FALSE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE)
    as.matrix.simstatespace(ssm, eta = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = FALSE, long = FALSE)
    print.simstatespace(ssm)
    plot.simstatespace(ssm, id = 1:3, time = 0:4)
    plot.simstatespace(ssm, eta = TRUE)

    # Type 2
    ssm <- simStateSpace::SimSSMLinGrowth(
      n = n,
      mu0 = mu0,
      sigma0 = sigma0,
      theta = theta,
      gamma_y = gamma_y,
      gamma_eta = gamma_eta,
      x = x,
      type = 2,
      time = time
    )

    as.data.frame.simstatespace(ssm, eta = TRUE)
    as.data.frame.simstatespace(ssm, eta = FALSE)
    as.data.frame.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.data.frame.simstatespace(ssm, eta = FALSE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE)
    as.matrix.simstatespace(ssm, eta = FALSE)
    as.matrix.simstatespace(ssm, eta = TRUE, long = FALSE)
    as.matrix.simstatespace(ssm, eta = FALSE, long = FALSE)
    print.simstatespace(ssm)
    plot.simstatespace(ssm, id = 1:3, time = 0:4)
    plot.simstatespace(ssm, eta = TRUE)

    # Error
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::expect_error(
          simStateSpace::SimSSMLinGrowth(
            n = n,
            mu0 = mu0,
            sigma0 = sigma0,
            theta = theta,
            gamma_y = gamma_y,
            gamma_eta = gamma_eta,
            x = x,
            type = 3,
            time = time
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "error type 1"),
      {
        testthat::expect_error(
          simStateSpace::SimSSMLinGrowth(
            n = n,
            mu0 = mu0,
            sigma0 = sigma0,
            theta = theta,
            type = 1,
            time = time
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "error type 2"),
      {
        testthat::expect_error(
          simStateSpace::SimSSMLinGrowth(
            n = n,
            mu0 = mu0,
            sigma0 = sigma0,
            theta = theta,
            type = 2,
            time = time
          )
        )
      }
    )
  },
  text = "test-simStateSpace-sim-ssm-lin-growth"
)