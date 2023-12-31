% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{SimSSM0Fixed}
\alias{SimSSM0Fixed}
\title{Simulate Data using a State Space Model Parameterization
for n > 1 Individuals (Fixed Parameters)}
\usage{
SimSSM0Fixed(
  n,
  mu0,
  sigma0_sqrt,
  alpha,
  beta,
  psi_sqrt,
  nu,
  lambda,
  theta_sqrt,
  time,
  burn_in
)
}
\arguments{
\item{n}{Positive integer.
Number of individuals.}

\item{mu0}{Numeric vector.
Mean of initial latent variable values
(\eqn{\boldsymbol{\mu}_{\boldsymbol{\eta} \mid 0}}).}

\item{sigma0_sqrt}{Numeric matrix.
Cholesky decomposition of the covariance matrix
of initial latent variable values
(\eqn{\boldsymbol{\Sigma}_{\boldsymbol{\eta} \mid 0}}).}

\item{alpha}{Numeric vector.
Vector of intercepts for the dynamic model
(\eqn{\boldsymbol{\alpha}}).}

\item{beta}{Numeric matrix.
Transition matrix relating the values of the latent variables
at time \code{t - 1} to those at time \code{t}
(\eqn{\boldsymbol{\beta}}).}

\item{psi_sqrt}{Numeric matrix.
Cholesky decomposition of the process noise covariance matrix
(\eqn{\boldsymbol{\Psi}}).}

\item{nu}{Numeric vector.
Vector of intercepts for the measurement model
(\eqn{\boldsymbol{\nu}}).}

\item{lambda}{Numeric matrix.
Factor loading matrix linking the latent variables
to the observed variables
(\eqn{\boldsymbol{\Lambda}}).}

\item{theta_sqrt}{Numeric matrix.
Cholesky decomposition of the measurement error covariance matrix
(\eqn{\boldsymbol{\Theta}}).}

\item{time}{Positive integer.
Number of time points to simulate.}

\item{burn_in}{Positive integer.
Number of burn-in points to exclude before returning the results.}
}
\value{
Returns a list of length \code{n}.
Each element is a list with the following elements:
\itemize{
\item \code{y}: A \code{t} by \code{k} matrix of values for the manifest variables.
\item \code{eta}: A \code{t} by \code{p} matrix of values for the latent variables.
\item \code{time}: A vector of discrete time points from 1 to \code{t}.
\item \code{id}: A vector of ID numbers of length \code{t}.
\item \code{n}: Number of individuals.
}
}
\description{
This function simulates data
using a state space model parameterization
for \code{n > 1} individuals.
In this model,
the parameters are invariant across individuals.
}
\details{
The measurement model is given by
\deqn{
    \mathbf{y}_{i, t}
    =
    \boldsymbol{\nu}
    +
    \boldsymbol{\Lambda}
    \boldsymbol{\eta}_{i, t}
    +
    \boldsymbol{\varepsilon}_{i, t}
    \quad
    \mathrm{with}
    \quad
    \boldsymbol{\varepsilon}_{i, t}
    \sim
    \mathcal{N}
    \left(
    \mathbf{0},
    \boldsymbol{\Theta}
    \right)
  }
where \eqn{\mathbf{y}_{i, t}}, \eqn{\boldsymbol{\eta}_{i, t}},
and \eqn{\boldsymbol{\varepsilon}_{i, t}}
are random variables and \eqn{\boldsymbol{\nu}},
\eqn{\boldsymbol{\Lambda}},
and \eqn{\boldsymbol{\Theta}} are model parameters.
\eqn{\mathbf{y}_{i, t}} is a vector of observed random variables
at time \eqn{t} and individual \eqn{i},
\eqn{\boldsymbol{\eta}_{i, t}} is a vector of latent random variables
at time \eqn{t} and individual \eqn{i},
and \eqn{\boldsymbol{\varepsilon}_{i, t}}
is a vector of random measurement errors
at time \eqn{t} and individual \eqn{i},
while \eqn{\boldsymbol{\nu}} is a vector of intercept,
\eqn{\boldsymbol{\Lambda}} is a matrix of factor loadings,
and \eqn{\boldsymbol{\Theta}} is the covariance matrix of
\eqn{\boldsymbol{\varepsilon}}.

The dynamic structure is given by
\deqn{
    \boldsymbol{\eta}_{i, t}
    =
    \boldsymbol{\alpha}
    +
    \boldsymbol{\beta}
    \boldsymbol{\eta}_{i, t - 1}
    +
    \boldsymbol{\zeta}_{i, t}
    \quad
    \mathrm{with}
    \quad
    \boldsymbol{\zeta}_{i, t}
    \sim
    \mathcal{N}
    \left(
    \mathbf{0},
    \boldsymbol{\Psi}
    \right)
  }
where \eqn{\boldsymbol{\eta}_{i, t}}, \eqn{\boldsymbol{\eta}_{i, t - 1}},
and \eqn{\boldsymbol{\zeta}_{i, t}} are random variables
and \eqn{\boldsymbol{\alpha}}, \eqn{\boldsymbol{\beta}},
and \eqn{\boldsymbol{\Psi}} are model parameters.
\eqn{\boldsymbol{\eta}_{i, t}} is a vector of latent variables
at time \eqn{t} and individual \eqn{i},
\eqn{\boldsymbol{\eta}_{i, t - 1}}
is a vector of latent variables at
time \eqn{t - 1} and individual \eqn{i},
and \eqn{\boldsymbol{\zeta}_{i, t}} is a vector of dynamic noise
at time \eqn{t} and individual \eqn{i} while \eqn{\boldsymbol{\alpha}}
is a vector of intercepts,
\eqn{\boldsymbol{\beta}} is a matrix of autoregression
and cross regression coefficients,
and \eqn{\boldsymbol{\Psi}} is the covariance matrix of
\eqn{\boldsymbol{\zeta}_{i, t}}.
}
\examples{
# prepare parameters
set.seed(42)
k <- p <- 3
I <- diag(k)
I_sqrt <- chol(I)
null_vec <- rep(x = 0, times = k)
n <- 5
mu0 <- null_vec
sigma0_sqrt <- I_sqrt
alpha <- null_vec
beta <- diag(x = 0.50, nrow = k)
psi_sqrt <- I_sqrt
nu <- null_vec
lambda <- I
theta_sqrt <- chol(diag(x = 0.50, nrow = k))
time <- 50
burn_in <- 0

# generate data
ssm <- SimSSM0Fixed(
  n = n,
  mu0 = mu0,
  sigma0_sqrt = sigma0_sqrt,
  alpha = alpha,
  beta = beta,
  psi_sqrt = psi_sqrt,
  nu = nu,
  lambda = lambda,
  theta_sqrt = theta_sqrt,
  time = time,
  burn_in = burn_in
)

str(ssm)

}
\references{
Chow, S.-M., Ho, M. R., Hamaker, E. L., & Dolan, C. V. (2010).
Equivalence and differences between structural equation modeling
and state-space modeling techniques.
\emph{Structural Equation Modeling: A Multidisciplinary Journal},
17(2), 303–332.
\doi{10.1080/10705511003661553}

Chow, S.-M., Losardo, D., Park, J., & Molenaar, P. C. M. (2023).
Continuous-time dynamic models: Connections to structural equation models
and other discrete-time models.
In R. H. Hoyle (Ed.), Handbook of structural equation modeling (2nd ed.).
The Guilford Press.

Shumway, R. H., & Stoffer, D. S. (2017).
\emph{Time series analysis and its applications: With R examples}.
Springer International Publishing.
\doi{10.1007/978-3-319-52452-8}
}
\seealso{
Other Simulation of State Space Models Data Functions: 
\code{\link{OU2SSM}()},
\code{\link{Sim2Matrix}()},
\code{\link{SimSSM0Vary}()},
\code{\link{SimSSM0}()},
\code{\link{SimSSMOUFixed}()},
\code{\link{SimSSMOUVary}()},
\code{\link{SimSSMOU}()},
\code{\link{SimSSMVARFixed}()},
\code{\link{SimSSMVARVary}()},
\code{\link{SimSSMVAR}()}
}
\author{
Ivan Jacob Agaloos Pesigan
}
\concept{Simulation of State Space Models Data Functions}
\keyword{sim}
\keyword{simStateSpace}
\keyword{ssm}
