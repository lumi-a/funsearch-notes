#import "preamble.typ": *; #show: preamble

#set heading(numbering: "1.")
#set outline.entry(fill: line(length: 100%, stroke: black.lighten(50%)))
#outline()

#v(2em)

= Dualising the LP

This is an ILP-formulation of the generalised-gasoline-problem @lucas[Figure 1.2]
$
  min thick &‖β-α‖_1 quad"s.t."\
  ∑_(l=1)^n ∑_(i=1)^m x_l Z_(i l)- ∑_(i=1)^(m-1) y_i &≤ β quad ∀ m∈[n]\
  ∑_(l=1)^n ∑_(i=1)^m x_l Z_(i l)- ∑_(i=1)^m y_i &≥ α quad ∀ m∈[n]\
  Z 𝟙 &≤ 𝟙\
  𝟙^T Z &≤ 𝟙^T\
  Z &∈ {0,1}^(n × n)\
  α,β &∈ ℝ^d
$

Before proceeding, let's introduce more notation:
- Let $𝟙≔(1,dots.c,1)^T ∈ℝ^n$ and $𝟘≔(0,dots.c,0)^T ∈ ℝ^n$
- Let $I$ be the $n×n$ identity matrix.
- Let $L ≔ mat(1, dots.c, 0; dots.v, dots.down, dots.v; 1, dots.c, 1)$ be the $n×n$ matrix with $1$ on its lower-triangle-entries (including the diagonal) and $0$ on its upper-triangle (excluding the diagonal).
- Let $y_(1:m) ≔ ∑_(i=1)^m y_i$, with $y_(1:0) ≔ 0$.

We relax the ILP's integrality-constraints and rewrite it into vector-form (which later helps me dualise the LP) like this:
#pagebreak()
$
  min thick ⟨(𝟘^T, dots.c, 𝟘^T, -1, 1), v⟩ quad "s.t."&\
  mat(
    -x_1 S, dots.c, dots.c, -x_n S, , 𝟘, 𝟙;
     //
    x_1 S, dots.c, dots.c, x_n S, , -𝟙, 𝟘;
     //
    -S, dots.c, dots.c, -S, , 𝟘, 𝟘;
     //
    -𝟙^T, 𝟘^T, dots.c, 𝟘^T, , 𝟘, 𝟘;
    𝟘^T, -𝟙^T, dots.down, dots.v, , dots.v, dots.v;
    dots.v, dots.down, dots.down, 𝟘^T, , 𝟘, 𝟘;
    𝟘^T, dots.c, 𝟘^T, -𝟙^T, , 𝟘, 𝟘;
     //
    I, 𝟘^T, dots.c, 𝟘^T, , 𝟘, 𝟘;
    𝟘^T, I, dots.down, dots.v, , dots.v, dots.v;
    dots.v, dots.down, dots.down, 𝟘^T, , 𝟘, 𝟘;
    𝟘^T, dots.c, 𝟘^T, I, , 𝟘, 𝟘;
    augment: #(hline: (1, 2, 3, 7))
  )
  overbrace(vec(Z_(1 1), dots.v, Z_(n 1), , Z_(1 2), dots.v, Z_(n 2), , dots.v, , Z_(1 n), dots.v, Z_(n n), , α, β), ≕ v)
  &≥
  mat(-y_(1:0); dots.v; -y_(1:n-1); y_(1:1); dots.v; y_(1:n); -𝟙; -𝟙; 𝟘; dots.v; 𝟘; augment: #(hline: (3, 6, 7, 8)))
$
Now that the LP is in a neat form, dualising is easy:
$
  max quad y_(1:1)⋅a_1 +sum_(i=2)^n y_(1:i)⋅(a_i - b_(i-1)) -⟨(s_1,…,s_n),𝟙⟩-⟨(t_1,…,t_n),𝟙⟩ quad"s.t."\
  mat(
    -x_1 S^T, x_1 S^T, -S^T, -𝟙, 𝟘, dots.c, 𝟘, I, 𝟘, dots.c, 𝟘;
    -x_1 S^T, x_1 S^T, -S^T, 𝟘, -𝟙, dots.down, dots.v, 𝟘, I, dots.down, dots.v;
    dots.v, dots.v, dots.v, dots.v, dots.down, dots.down, 𝟘, dots.v, dots.down, dots.down, 𝟘;
    -x_1 S^T, x_1 S^T, -S^T, 𝟘, dots.c, 𝟘, -𝟙, 𝟘, dots.c, 𝟘, I; ;
    𝟘^T, -𝟙^T, 𝟘^T, 𝟘^T, dots.c, 𝟘^T, 𝟘^T, 𝟘^T, dots.c, 𝟘^T, 𝟘^T;
    𝟙^T, 𝟘^T, 𝟘^T, 𝟘^T, dots.c, 𝟘^T, 𝟘^T, 𝟘^T, dots.c, 𝟘^T, 𝟘^T;
    augment: #(vline: (1, 2, 3, 7))
  )
  overbrace(mat(b_1; dots.v; b_n; a_1; dots.v; a_n; s_1; dots.v; s_n; t_1; dots.v; t_n; p_(1 1); dots.v; p_(n 1); p_(1 2); dots.v; dots.v; p_(1 n); dots.v; p_(n n); augment: #(hline: (3, 6, 9, 12))), ≕ w)
  = vec(𝟘, dots.v, 𝟘, -1, 1)
  quad "and" quad w≥0
$

= Defining the instance

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

= The iterative-rounding algorithm has approximation-ratio $≥d$

== The optimal solution has value $≤ 𝒪(2^k)$
For this, we supply a permutation of the $X$ that yields value $𝒪(2^k)$.

= Code

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

#bibliography("bibliography.bib")

