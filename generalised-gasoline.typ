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
    -x_1 S, -x_2 S, dots.c, -x_n S, , 𝟘, 𝟙;
     //
    x_1 S, x_2 S, dots.c, x_n S, , -𝟙, 𝟘;
     //
    -I, -I, dots.c, -I, , 𝟘, 𝟘;
     //
    -𝟙^T, 𝟘^T, dots.c, 𝟘^T, , 0, 0;
    𝟘^T, -𝟙^T, dots.down, dots.v, , dots.v, dots.v;
    dots.v, dots.down, dots.down, 𝟘^T, , 0, 0;
    𝟘^T, dots.c, 𝟘^T, -𝟙^T, , 0, 0;
     //
    I, , , , , 𝟘, 𝟘;
    , I, , , , dots.v, dots.v;
    , , dots.down, , , 𝟘, 𝟘;
    , , , I, , 𝟘, 𝟘;
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
    -x_1 S^T, x_1 S^T, -I, -𝟙, 𝟘, dots.c, 𝟘, I, ;
    -x_2 S^T, x_2 S^T, -I, 𝟘, -𝟙, dots.down, dots.v, , I;
    dots.v, dots.v, dots.v, dots.v, dots.down, dots.down, 𝟘, , , dots.down;
    -x_n S^T, x_n S^T, -I, 𝟘, dots.c, 𝟘, -𝟙, , , , I; ;
    𝟘^T, -𝟙^T, 𝟘^T, 0, dots.c, 0, 0, 𝟘^T, dots.c, 𝟘^T, 𝟘^T;
    𝟙^T, 𝟘^T, 𝟘^T, 0, dots.c, 0, 0, 𝟘^T, dots.c, 𝟘^T, 𝟘^T;
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

Both $X$ and $Y$ have length $2(2^k - 1)(d-1)$. The sum of the vectors in $X$ also equals the sum of the vectors in $Y$, which we won't prove here, but will _implicitly_ prove in @opt-upper-bound.

= The iterative-rounding algorithm has approximation-ratio $≥d$

== The optimal value is #Green[somewhere around] $≤2^k$ <opt-upper-bound>
For this, we define a permutation of the $X$ and prove it yields value $𝒪(2^k)$.
$
  π(X)
  quad≔quad
  underbrace(sum_(j=2)^d [2^k e_1,thick 2e_j], #[≕ "First sum"])
  + underbrace(sum_(i=1)^(k-1) sum_(1)^(2^i) sum_(j=2)^d [2^k e_1,thick u_i e_1 + 2 e_j], #[≕ "Second Sum"]),
$
This is indeed a permutation:
- The first sum is sourced from the last part of the definition of $X$.
- The second sum must therefore be a permutation of the first part of the definition of $X$ together with the remaining $∑_(1)^((d-1)⋅(2^k-2))⋅[2^k e_1]$. But that is true, because the second sum has exactly $(d-1)⋅(2^(k)-2)$ summands (a "summand" being a 2-element-lists).

Remembering that $u_1=2^(k-1)$, let's take a look at the first two prefix-sums:
$
  &π(X)_1 &=& 2^k e_1\
  &π(X)_1 - Y_1 &=& 2^k e_1 - (2^(k-1)e_1 + e_2) &=& 2^(k-1)e_1 - e_2\
  &π(X)_1 - Y_1 + π(X)_2 &=& 2^(k-1)e_1 - e_2 + 2e_2 &=& 2^(k-1)e_1 + e_2\
  &π(X)_1 - Y_1 + π(X)_2 - Y_2 &=& 2^(k-1)e_1 + e_2 - 2^(k-1)e_1 - e_2 &=& 𝟘\
$
Indeed, $π(X)_1 - Y_1 + π(X)_2 - Y_2$. This is excellent, because it means we can always skip the first two elements when calculating the next prefix-sums.

- The proof that this applies to the first $2d$ prefix-sums is the same as the four equations above.
- The proof that this applies to the remaining prefix-sums: Having removed the initial elements, the remainder of $π(X)$ and $Y$ look like this (we do an index-shift on $Y$'s $i$-sum):
  $
    "remainder of" π(X) = sum_(i=1)^(k-1) sum_(1)^(2^i) sum_(j=2)^d [2^k e_1,thick u_i e_1 + 2 e_j],
    quad quad
    "remainder of" Y = ∑_(i=1)^(k-1) ∑_(1)^(2^(i+1)) ∑_(j=2)^d [u_(i+1) e_1 + e_j]
  $
  Note that the middle sum ends at $2^i$ for $π(X)$, but at $2^(i+1)$ for $Y$, but that $π(X)$ sums over $2$-element-lists while $Y$ sums over $1$-element-lists. Fix any $i$. We will now look at the prefix-sums of:
  $
    X̃ ≔ sum_(j=2)^d [2^k e_1,thick u_i e_1 + 2 e_j],
    quad quad
    Ỹ ≔ (∑_(j=2)^d [u_(i+1) e_1 + e_j]) + (∑_(j=2)^d [u_(i+1) e_1 + e_j])
  $
  These make up the remainder of $π(X)$ and the remainder of $Y$. As we will show next, the prefix-sums of $X̃$ and $Ỹ$ sum to $0$, meaning this covers all the prefix-sums of the remainder of $π(X)$ and the remainder of $Y$.

  #Green[Todo]

#Green[Todo]

== The iterative rounding algorithm achieves value #Green[somewhere around] $≥ 2^k d$
_Claim_: The iterative rounding algorithm sets the first $2⋅(2^(k-1)-1)(d-1)$ elements of $X$ in place. That is, it sets $Z_(l,l)=1$ for $1≤l≤2⋅(2^(k-1)-1)(d-1)$.

_Proof_: Assume the algorithm already set $Z_(l,l)=1$ for $1≤l≤L$, for some fixed $L ≤ 2⋅(2^(k-1)-1)(d-1)$. The algorithm will now try to set all $Z_(m,L+1)=1$ for $L+1≤m≤n$ and will finally choose the one with smallest LP-value, breaking ties by choosing the smallest $m$. We will therefore, for all choices of $m$, calculate lower-bounds on the LP-value via the dual LP, conclude that $m=L+1$ achieves the smallest LP-value, and (being the smallest $m$) also wins the tie-break.

- #Green[Todo]



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

