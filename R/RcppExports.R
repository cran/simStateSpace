# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Convert Parameters from the Linear Stochastic Differential Equation Model
#' to State Space Model Parameterization
#'
#' This function converts parameters from
#' the linear stochastic differential equation model
#' to state space model parameterization.
#'
#' @details Let the linear stochastic equation model be given by
#'   \deqn{
#'     \mathrm{d}
#'     \boldsymbol{\eta}_{i, t}
#'     =
#'     \left(
#'       \boldsymbol{\iota}
#'       +
#'       \boldsymbol{\Phi}
#'       \boldsymbol{\eta}_{i, t}
#'     \right)
#'     \mathrm{d} t
#'     +
#'     \boldsymbol{\Sigma}^{\frac{1}{2}}
#'     \mathrm{d}
#'     \mathbf{W}_{i, t}
#'   }
#'   for individual \eqn{i} and time \eqn{t}.
#'   The discrete-time state space model
#'   given below
#'   represents the discrete-time solution
#'   for the linear stochastic differential equation.
#'   \deqn{
#'     \boldsymbol{\eta}_{i, t_{{l_{i}}}}
#'     =
#'     \boldsymbol{\alpha}_{\Delta t_{{l_{i}}}}
#'     +
#'     \boldsymbol{\beta}_{\Delta t_{{l_{i}}}}
#'     \boldsymbol{\eta}_{i, t_{l_{i} - 1}}
#'     +
#'     \boldsymbol{\zeta}_{i, t_{{l_{i}}}},
#'     \quad
#'     \mathrm{with}
#'     \quad
#'     \boldsymbol{\zeta}_{i, t_{{l_{i}}}}
#'     \sim
#'     \mathcal{N}
#'     \left(
#'     \mathbf{0},
#'     \boldsymbol{\Psi}_{\Delta t_{{l_{i}}}}
#'     \right)
#'   }
#'   with
#'   \deqn{
#'       \boldsymbol{\beta}_{\Delta t_{{l_{i}}}}
#'       =
#'       \exp{
#'         \left(
#'           \Delta t
#'           \boldsymbol{\Phi}
#'         \right)
#'       },
#'   }
#'
#'   \deqn{
#'       \boldsymbol{\alpha}_{\Delta t_{{l_{i}}}}
#'       =
#'       \boldsymbol{\Phi}^{-1}
#'       \left(
#'         \boldsymbol{\beta} - \mathbf{I}_{p}
#'       \right)
#'       \boldsymbol{\iota}, \quad \mathrm{and}
#'   }
#'
#'   \deqn{
#'       \mathrm{vec}
#'       \left(
#'         \boldsymbol{\Psi}_{\Delta t_{{l_{i}}}}
#'       \right)
#'       =
#'       \left[
#'         \left(
#'           \boldsymbol{\Phi} \otimes \mathbf{I}_{p}
#'         \right)
#'         +
#'         \left(
#'           \mathbf{I}_{p} \otimes \boldsymbol{\Phi}
#'         \right)
#'       \right]
#'       \left[
#'         \exp
#'         \left(
#'           \left[
#'             \left(
#'               \boldsymbol{\Phi} \otimes \mathbf{I}_{p}
#'             \right)
#'             +
#'             \left(
#'               \mathbf{I}_{p} \otimes \boldsymbol{\Phi}
#'             \right)
#'           \right]
#'           \Delta t
#'         \right)
#'         -
#'         \mathbf{I}_{p \times p}
#'       \right]
#'       \mathrm{vec}
#'       \left(
#'         \boldsymbol{\Sigma}
#'       \right)
#'   }
#'   where \eqn{t} denotes continuous-time processes
#'   that can be defined by any arbitrary time point,
#'   \eqn{t_{l_{i}}} the \eqn{l^\mathrm{th}}
#'   observed measurement occassion for individual \eqn{i},
#'   \eqn{p} the number of latent variables and
#'   \eqn{\Delta t} the time interval.
#'
#' @references
#'   Harvey, A. C. (1990).
#'   Forecasting, structural time series models and the Kalman filter.
#'   Cambridge University Press.
#'   \doi{10.1017/cbo9781107049994}
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param iota Numeric vector.
#'   An unobserved term that is constant over time
#'   (\eqn{\boldsymbol{\iota}}).
#' @param phi Numeric matrix.
#'   The drift matrix
#'   which represents the rate of change of the solution
#'   in the absence of any random fluctuations
#'   (\eqn{\boldsymbol{\Phi}}).
#' @param sigma_l Numeric matrix.
#'   Cholesky factorization (`t(chol(sigma))`)
#'   of the covariance matrix of volatility
#'   or randomness in the process
#'   \eqn{\boldsymbol{\Sigma}}.
#' @param delta_t Numeric.
#'   Time interval
#'   (\eqn{\Delta_t}).
#'
#' @return Returns a list of state space parameters:
#'   - `alpha`: Numeric vector.
#'     Vector of constant values for the dynamic model
#'     (\eqn{\boldsymbol{\alpha}}).
#'   - `beta`: Numeric matrix.
#'     Transition matrix relating the values of the latent variables
#'     from the previous time point to the current time point.
#'     (\eqn{\boldsymbol{\beta}}).
#'   - `psi_l`: Numeric matrix.
#'     Cholesky factorization (`t(chol(psi))`)
#'     of the process noise covariance matrix
#'     \eqn{\boldsymbol{\Psi}}.
#'
#' @examples
#' p <- 2
#' iota <- c(0.317, 0.230)
#' phi <- matrix(
#'   data = c(
#'    -0.10,
#'    0.05,
#'    0.05,
#'    -0.10
#'  ),
#'  nrow = p
#' )
#' sigma <- matrix(
#'   data = c(
#'     2.79,
#'     0.06,
#'     0.06,
#'     3.27
#'   ),
#'   nrow = p
#' )
#' sigma_l <- t(chol(sigma))
#' delta_t <- 0.10
#'
#' LinSDE2SSM(
#'   iota = iota,
#'   phi = phi,
#'   sigma_l = sigma_l,
#'   delta_t = delta_t
#' )
#'
#' @family Simulation of State Space Models Data Functions
#' @keywords simStateSpace sim linsde
#' @export
LinSDE2SSM <- function(iota, phi, sigma_l, delta_t) {
    .Call(`_simStateSpace_LinSDE2SSM`, iota, phi, sigma_l, delta_t)
}

.SimSSMFixed0 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l) {
    .Call(`_simStateSpace_SimSSMFixed0`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l)
}

.SimSSMFixed1 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma) {
    .Call(`_simStateSpace_SimSSMFixed1`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma)
}

.SimSSMFixed2 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma, kappa) {
    .Call(`_simStateSpace_SimSSMFixed2`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma, kappa)
}

.SimSSMIVary0 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l) {
    .Call(`_simStateSpace_SimSSMIVary0`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l)
}

.SimSSMIVary1 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma) {
    .Call(`_simStateSpace_SimSSMIVary1`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma)
}

.SimSSMIVary2 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma, kappa) {
    .Call(`_simStateSpace_SimSSMIVary2`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, nu, lambda, theta_l, x, gamma, kappa)
}

.SimSSMLatFixed0 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l) {
    .Call(`_simStateSpace_SimSSMLatFixed0`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l)
}

.SimSSMLatFixed1 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, x, gamma) {
    .Call(`_simStateSpace_SimSSMLatFixed1`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, x, gamma)
}

.SimSSMLatIVary0 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l) {
    .Call(`_simStateSpace_SimSSMLatIVary0`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l)
}

.SimSSMLatIVary1 <- function(n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, x, gamma) {
    .Call(`_simStateSpace_SimSSMLatIVary1`, n, time, delta_t, mu0, sigma0_l, alpha, beta, psi_l, x, gamma)
}

.SimSSMLinSDEIVary0 <- function(n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, ou = FALSE) {
    .Call(`_simStateSpace_SimSSMLinSDEIVary0`, n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, ou)
}

.SimSSMLinSDEIVary1 <- function(n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, x, gamma, ou = FALSE) {
    .Call(`_simStateSpace_SimSSMLinSDEIVary1`, n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, x, gamma, ou)
}

.SimSSMLinSDEIVary2 <- function(n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, x, gamma, kappa, ou = FALSE) {
    .Call(`_simStateSpace_SimSSMLinSDEIVary2`, n, time, delta_t, mu0, sigma0_l, iota, phi, sigma_l, nu, lambda, theta_l, x, gamma, kappa, ou)
}

