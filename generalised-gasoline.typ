#import "preamble.typ": *; #show: preamble

Fix positive integers $d≥2$ (dimension) and $k≥2$ (some parameter that, for fixed $d$, we'll send to infinity later on). Like in Lucas' thesis, define $u_i ≔ 2^k ⋅ (1-2^i)$.

Recall that Lucas' $1$-dimensional instance looked like this:
$
  X &= \[underbrace(u_1\, u_1, 2^1 "times"), thick
  underbrace(u_2\, ...\, u_2, 2^2 "times"), thick
  ..., thick
  underbrace(u_(k-1)\, ...\, u_(k-1), 2^(k-1) "times"), thick
  underbrace(2^k\, ...\, 2^k, 2^(k) - 1 "times"), thick
  0\] \
  Y &= \[underbrace(u_1\, u_1, 2^1 "times"), thick
  underbrace(u_2\, ...\, u_2, 2^2 "times"), thick,
  ..., thick
  underbrace(u_(k-1)\, ...\, u_(k-1), 2^(k-1) "times"), thick
  underbrace(u^k\, ...\, u^k, 2^(k) "times")\]
$
To introduce notation (adding two lists means concatenating them, which is associative but not commutative), these $1$-dimensional instances can also be written as:
$
  X &= (∑_(i=1)^(k-1) ∑_(1)^(2^i) [u_i]) + (∑_(1)^(2^k - 1) [2^k]) + [0]\
  Y &= ∑_(i=1)^(k) ∑_(1)^(2^i) [u_i]
$
Let $e_j = (0,…,0,1,0,…0)$ denote the $j$-th $d$-dimensional basis-vector.
Define a $d$-dimensional instance:
$
  X &= (∑_(i=1)^(k-1) ∑_(1)^(2^i) ∑_(j=2)^d [u_i e_1 + 2 e_j]) + ∑_(j=2)^d ((∑_(1)^(2^k-1) [2^k e_1])+[2 e_j])\
  Y &= ∑_(i=1)^(k) ∑_(1)^(2^i) ∑_(j=2)^d [u_i e_1 + e_j]
$

These look intimidating. @generating-code contains python-code generating these instances.

Both $X$ and $Y$ have length $2(2^k - 1)(d-1)$. The sum of the vectors in $X$ also equals the sum of the vectors in $Y$.

#figure(
  ```py
  import numpy as np

  d = 4
  k = 3
  xs: list[np.ndarray] = []
  ys: list[np.ndarray] = []

  for i in range(1, k):
      u = 2**k - 2 ** (k - i)
      for _ in range(2**i):
          for axis in range(1, d):
              vec = np.zeros(d, dtype=int)
              vec[0] = u
              vec[axis] = 2
              xs.append(vec)

  for axis in range(1, d):
      for _ in range(2**k - 1):
          vec = np.zeros(d, dtype=int)
          vec[0] = 2**k
          xs.append(vec)
      vec = np.zeros(d, dtype=int)
      vec[axis] = 2
      xs.append(vec)

  for i in range(1, k + 1):
      u = 2**k - 2 ** (k - i)
      for _ in range(2**i):
          for axis in range(1, d):
              vec = np.zeros(d, dtype=int)
              vec[0] = u
              vec[axis] = 1
              ys.append(vec)

  assert len(xs) == len(ys)
  assert (sum(xs) - sum(ys) == 0).all()
  ```,
  caption: [Python-Code generating the $d$-dimensional instance.],
) <generating-code>

This is an ILP-formulation of the generalised-gasoline-problem @lucas[Figure 1.2]
$
  min thick &‖β-α‖_1 quad"s.t."\
  ∑_(l=1)^n ∑_(i=1)^k x_l Z_(i l)- ∑_(i=1)^(k-1) y_i &≤ β quad ∀ k∈[n]\
  ∑_(l=1)^n ∑_(i=1)^k x_l Z_(i l)- ∑_(i=1)^k y_i &≥ α quad ∀ k∈[n]\
  Z 𝟙 &≤ 𝟙\
  𝟙^T Z &≤ 𝟙^T\
  Z &∈ {0,1}^(n × n)\
  α,β &∈ ℝ^d
$
/*
Or, written differently:
$
  min thick &𝟙^T (β-α) quad"s.t."\
  β - ∑_(l=1)^n ∑_(i=1)^k x_l Z_(i l) &≥ - ∑_(i=1)^(k-1) y_i quad ∀ k∈[n]\
  ∑_(l=1)^n ∑_(i=1)^k x_l Z_(i l)- α &≥ ∑_(i=1)^k y_i quad ∀ k∈[n]\
  -Z 𝟙 &≥ -𝟙\
  -𝟙^T Z &≥ -𝟙^T\
  Z &∈ {0,1}^(n × n)\
  α,β &∈ ℝ^d
$
Relaxing the 0-1-constraint on $Z$ to $Z_(i j)≥0$ (the constraint $Z_(i j)≤1$ is already implied by $Z 𝟙 ≤ 𝟙$), we get a continuous LP, whose dual is:
$
  max thick &∑_(k=1)^n (a_k^T ∑_(i=1)^k y_i - b_k^T ∑_(i=1)^(k-1) y_i ) quad"s.t."\
  a_k &∈ ℝ_(≥0)^d quad ∀k∈[n]\
  b_k &∈ ℝ_(≥0)^d quad ∀k∈[n]\
$
*/

/*
Let $S ≔ mat(1, 0, dots.c, 0; 1, 1, dots.down, dots.v; dots.v, , dots.down, 0; 1, 1, dots.c, 1)$ be the $n×n$ lower-triangular-1-matrix, and $I ∈ ℝ^(n×n)$ the identity-matrix. The above LP can be rewritten as:
$
  min thick &‖β-α‖_1 quad"s.t."\
  S Z x - (S-I)y &≤ β\
  S Z x - S y &≥ α\
  Z 𝟙 &≤ 𝟙\
  𝟙^T Z &≤ 𝟙^T\
  Z &∈ {0,1}^(n × n)\
  α,β &∈ ℝ^d
$
*/

= The iterative-rounding algorithm has approximation-ratio $≥d$

#bibliography("bibliography.bib")
