#import "@local/simple-note:0.0.1": *
#show: simple-note.with(
  title: [
    Bayes statistics and Monte Carlo simulations
  ],
  date: datetime(year: 2026, month: 2, day: 24),
  authors: (
    (
      name: "Rao",
      github: "https://github.com/Peng-Rao",
      homepage: "https://github.com/Peng-Rao",
    ),
  ),
  affiliations: (
    (
      id: "1",
      name: "Politecnico di Milano",
    ),
  ),
  // cover-image: "./figures/polimi_logo.png",
)
#set math.cases(gap: 1em)

= Principles of Bayesian learning
== Basic probability
The probability $P(A)$ of the event $A$ is a number in the interval $[0, 1]$ that quantifies the degree of belief or confidence in the truth of the event $A$.

#theorem("Properties of probability")[
  - $0 lt.eq P(A) lt.eq 1$ for a event $A subset Omega$;
  - $P(Omega)=1$
  - $P(union_n A_n)= sum_n P(A_n)$ where $A_n$ are disjoint.
]

=== Conditional probability
If $H$ is such that $P(H) > 0$, the conditional probability (or posterior) of $E$ given $H$ is defined as
$
  P(E|H):= P(E inter H) / P(H)
$

=== Total probability
If $Omega = H_1 union H_2$, $H_1 inter H_2 = emptyset$, $P(H_1) > 0$ and $P(H_2) > 0$, then
$
  P(E) = P(E|H_1)P(H_1) + P(E|H_2)P(H_2).
$

=== Bayes theorem
If $E$ and $H_1, H_2$ are events such that $P(H_1), P(H_2), P(E) eq.not 0$ and $Omega = H_1 union H_2$, $H_1 inter H_2 = emptyset$, then
$
  P(H_1|E) = (P(E|H_1)P(H_1)) / (P(E|H_1)P(H_1) + P(E|H_2)P(H_2))
$

Learning process: The posterior
$
  P(H|E)
$
is the updated probability of the hypothesis $H$ given we observed $E$.

#pagebreak()

== Random variables and densities
A random variable (r.v.) is a number $X$ (result of an experiment, random phenomena, etc) whose value is not completely known a priori (not deterministic).

A random variable will be characterized by its law (probability distribution), expressed by a density $f_X(x)$. We shall consider two types of r.v.
- Discrete r.v.
- Continuous r.v.

=== Discrete random variables
A random variable $X$ is *discrete* if it takes values in a discrete (countable) set: $D = {x_1, x_2, ...}$, i.e. $P{X in D} = 1$. Moreover, given any set $E subset RR$
$
  P r o b {X in E} = P{X in E} = sum_(x in E) f(x).
$
for $f(x) = p(x) = P{X = x}$ (probability mass function/discrete density).

=== Continuous random variables
The r.v. $X$ has a continuous distribution if for every set $E subset RR$
$
  P r o b {X in E} = P{X in E} = integral_E f(x) dif x.
$
where the *density* $f: RR arrow RR$ is such that $f(x) gt.eq 0$ and $integral_(-oo)^(+oo) f(x) dif x = 1$.

=== Statistical Models
A statistical model is described by a family of densities depending on a parameter:
$
  f(x|theta): x in cal(X) subset RR^n quad theta in Theta
$

$x in cal(X) subset RR^n$ is the variable/observation and $theta in Theta subset RR^m$ is the parameter
- $X tilde f(x|theta)$ is a random variable with denisty $f(x|theta)$ and represents the observation process,
- $X = x$ is the specific data we observe. Typically $X = (X_1, ..., X_n)$ is a vector!

- *Normal:* $cal(N)(mu, sigma^2)$:
$
  f(x|theta) = (e^(-(x-mu)^2/(2sigma^2))) / sqrt(2pi sigma^2), quad x in RR = cal(X), quad theta = (mu, sigma^2) in RR times RR_+ = Theta
$

- *Bernoulli:* $B e r(theta)$:
  $
    f(x|theta) = theta^x (1-theta)^(1-x), quad x in {0, 1} = cal(X), quad theta in (0, 1) = Theta
  $

- *Binomial:* $B i n(n, theta)$:
  $
    f(x|theta) = binom(n, x) theta^x (1-theta)^(n-x) quad x in {0, 1, ..., n} = cal(X), quad theta in (0, 1) = Theta
  $

#pagebreak()

== Joint distribution
A a random vector $(X, Y)$ is characterized by its joint distribution and in particular by its joint density.

For every set $A subset RR^2$
$
  P{(X, Y) in A} = cases(
    sum_((x comma y) in A) f(x comma y) quad & "discrete case",
    integral_(A subset RR^2) f(x comma y) dif x dif y quad & "continuous case"
  )
$
where the *density* $f: RR^2 arrow RR$ is such that $f(x, y) gt.eq 0$ and $integral_(-oo)^(+oo) integral_(-oo)^(+oo) f(x, y) dif x dif y = 1$ or $sum_x sum_y f(x, y) = 1$.

=== Marginal distribution

If $f(x, theta)$ is a joint density for $(X, theta.alt)$ then the *marginal density* of $X$ ($theta.alt$, respectively) is obtained by
$
  f_X (x) = cases(
    sum_theta f(x comma theta) quad & "disc.",
    integral_(-oo)^(+oo) f(x comma theta) dif theta quad & "cont."
  ) quad quad
  f_theta.alt (theta) = cases(
    sum_x f(x comma theta) quad & "disc.",
    integral_(-oo)^(+oo) f(x comma theta) dif x quad & "cont."
  )
$

=== Conditional distribution
The conditional density of $theta.alt$ given $X = x$ is defined by
$
  f_(theta.alt|X) (theta|x) = (f(x, theta.alt)) / (f_X (x)).
$

The conditional density of $X$ given $theta.alt = theta$ is defined by
$
  f_(X|theta.alt) (x|theta) = (f(x, theta.alt)) / (f_theta.alt (theta)).
$

And the joint density can be factorized as
$
  f(x, theta) = f_(X|theta.alt) (x|theta) f_theta.alt (theta) = f_(theta.alt|X) (theta|x) f_X (x).
$

=== Bayes theorem
We can get the Bayes theorem by dividing the two expressions of the joint density:
$
  f_(theta.alt|X) (theta|x) = (f_(X|theta.alt) (x|theta) f_theta.alt (theta)) / (f_X (x))
$

A Bayesian statistical model is made of
+ $f(x|theta) = f_(X|theta.alt) (x|theta)$: the conditional density of $X$ given $theta$, called *likelihood*: given the parameter $theta$ the observation process $X$ is distributed according to $f(x|theta)$
+ $pi(theta)=f_theta.alt (theta)$: the marginal density of $theta$, called *prior*: a probability distribution over the parameter space $Theta$.
+ The joint distributiof $(theta.alt, X)$: $f(theta, x) := f(x|theta) pi(theta)$
+ The marginal distribution of $X$:$ m(x) = f_X (x) = integral f (x|theta) pi(theta) dif theta $
+ the posterior distribution of $theta.alt$: $ pi(theta|x) = f_(theta.alt|X) (theta|x)= (f(x|theta) pi(theta)) / (integral_Theta f(x|u) pi(u) dif u) $

#pagebreak()
== Bayesian Core
=== Prior
=== Likelihood
=== Posterior




== Prior and posterior distributions
- The joint distribution
- The marginal distribution
- the posterior distribution

=== Conditional density



=== Joint distribution


