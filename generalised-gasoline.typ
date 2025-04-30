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
To introduce notation (adding two lists means concatenating them), these $1$-dimensional instances can also be written as:
$
  X &= (∑_(i=1)^(k-1) ∑_(1)^(2^i) [u_i]) + (∑_(1)^(2^k - 1) [2^k]) + [0]\
  Y &= ∑_(i=1)^(k) ∑_(1)^(2^i) [u_i]
$
Let $e_j = (0,…,0,1,0,…0)$ denote the $j$-th $d$-dimensional basis-vector.
Define a $d$-dimensional instance:
$
  X &= (∑_(i=1)^(k-1) ∑_(1)^(2^i) ∑_(j=2)^d [u_i e_1 + 4 e_j]) + ∑_(j=2)^d ((∑_(1)^(2^k-1) [2^k e_1])+[4 e_j])\
  Y &= ∑_(i=1)^(k) ∑_(1)^(2^i) ∑_(j=2)^d [u_i e_1 + 2 e_j]
$

These look quite intimidating. @generating-code contains python-code generating these instances.

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
              vec[axis] = 4
              xs.append(vec)

  for axis in range(1, d):
      for _ in range(2**k - 1):
          vec = np.zeros(d, dtype=int)
          vec[0] = 2**k
          xs.append(vec)
      vec = np.zeros(d, dtype=int)
      vec[axis] = 4
      xs.append(vec)

  for i in range(1, k + 1):
      u = 2**k - 2 ** (k - i)
      for _ in range(2**i):
          for axis in range(1, d):
              vec = np.zeros(d, dtype=int)
              vec[0] = u
              vec[axis] = 2
              ys.append(vec)

  assert len(xs) == len(ys)
  assert (sum(xs) - sum(ys) == 0).all()
  ```,
  caption: [Python-Code generating the $d$-dimensional instance.],
) <generating-code>
