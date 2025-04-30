#import "preamble.typ": *; #show: preamble
#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart

Fix the dimension $d≥2$. Define $c ≔ (√(5d^2 -2d +1)+d-1) / 2$. We believe #link("https://www.wolframalpha.com/input?i=(%E2%88%9A(5d%5E2%20-2d%20%2B1)%2Bd-1)%2F2%20%3E%20d")[WolframAlpha] that $c>d$.

Let $e_i$ be the $i$th $d$-dimensional standard-basis-vector. Consider the following weighted-discrete-kmedian-clustering-problem on $d+2$ points:
$
  (0,…,0),quad quad
  (1,…,1),quad quad
  -c ⋅ e_1,#h(0.5em)
  …,#h(0.5em)
  -c ⋅ e_d,
$
where we assign $(1,…,1)$ a weight of $∞$, and all other points a weight of $1$.

#figure(
  cetz.canvas({
    import cetz.draw: *

    plot.plot(
      {
        plot.add(((0, 0), (-2.56155281281, 0), (0, -2.56155281281)), mark: "o", style: (stroke: none), mark-style: (stroke: none, fill: red), mark-size: 0.25)
        plot.add(((1, 1),), mark: "o", mark-style: (stroke: none, fill: blue), mark-size: 0.5)
      },
      size: (16, 12),
      x-grid: true,
      x-min: -4.5,
      x-max: 3.5,
      y-min: -3.5,
      y-max: 2.5,
      x-tick-step: 1,
      y-tick-step: 1,
      y-grid: true,
      axis-style: "school-book",
    )
  }),
  caption: [The instance for $d=2$. The three #Red[red] points have weight $1$, the large #Blue[blue] point has weight $∞$.],
)

_Claim_: This instance has a discrete-kmedian-price-of-hierarchy of at least $c / d$.

_Proof_: Let $H$ be an optimal hierarchy, and let $H_k$ (for $k=1,…,d+2$) be its $k$-clustering. Assume, for contradiction, that for every $k$, the cost of $H_k$ is smaller than $c / d$ times the optimum $k$-clustering.

- For $k=d+1$, we need to put exactly two points in a cluster, while all other points are contained in singleton-clusters. We distinguish all possible pairs of points:
  + $(0,…,0)$ and $(1,…,1)$ has cost $d$.
  + $(0,…,0)$ and any $-c⋅e_i$ has cost $c$.
  + $(1,…,1)$ and any $-c⋅e_i$ has cost $d+c$.

  Because $d<c$, it's optimal to cluster $(0, …, 0)$ and $(1, …, 1)$, and $H_(d+1)$ must cluster $(0, …, 0)$ and $(1,…,1)$ together because every other option is at least $c / d$ times more expensive.
- For $k=2$: Because $H$ is a hierarchical clustering, we now know that $H_2$ must have $(0,…0)$ and $(1,…,1)$ in the same cluster. So we know that $H_2$ must consist of two clusters: The first cluster contains $(0,…,0), (1,…,1)$, and some number $0≤n≤d-1$ of the $-c e_i$, while the second cluster contains the rest of the $-c e_i$. Due to symmetry, this number $n$ is already sufficient for calculating the cost of $H_2$. We will calculate the cost for fixed $n$, and then get a lower bound for the cost of $H_2$ by choosing the $n$ that results in the smallest cost.

  The center of the first cluster must be $(1,…,1)$, as it has weight $∞$, while all other points have weight $1$. Due to symmetry the cost of the second cluster does not depend on its center. The total cost is:
  $
    overbrace(‖(1,…,1) - (0,…,0)‖_1 + n ⋅ ‖(1,…,1) - (-c⋅e_i)‖_1, "cost of first cluster")
    + overbrace((d-n-1) ⋅ ‖c e_1 - c e_2‖_1, "cost of second cluster")
    quad = quad d + 2c d -2c + n(d-c)
  $

  Thus, because $d-c < 0$, the best possible choice for $n$ is $d-1$, where $H_2$ would achieve a cost of $d(c+d)-c$. This is only a lower-bound for the cost of $H_2$, because $H_2$ is also subject to hierarchy-constraints from other $H_k, k>2$.

  Now, for an upper-bound on the _optimal_ (non-hierarchical) $2$-clustering: The clustering having ${(1,…,1)}$ as its first cluster, and the other points as its second cluster (choosing $(0,…0)$ as its center) has cost:
  $
    overbrace(0, "cost of"\ "first cluster") + overbrace(∑_(i=1)^d ‖(0,…,0)+c e_i‖_1, "cost of"\ "second cluster")
    quad = quad d ⋅ c
  $
  Comparing the cost of $H_k$ to the optimal cost:
  $
    ("Cost of" H_2) / ("Cost of optimal 2-clustering")
    quad≥quad (d (c+d)-c) / (d c)
    quad=quad 1+d / c - 1 / d
  $
  However, WolframAlpha #link("https://www.wolframalpha.com/input?i=1%2Bd%2F((%E2%88%9A(5d%5E2%20-2d%20%2B1)%2Bd-1)%2F2)%20-%201%2Fd%20%3D%20(%E2%88%9A(5d%5E2%20-2d%20%2B1)%2Bd-1)%2F2%2Fd")[promises us] that $1+d / c - 1 / d = c / d$. This contradicts our above assumption that the cost-ratio between $H_k$ and the optimal $k$-clustering is always strictly less than $c / d$.

Thus, the instance's price-of-hierarchy is at least $c\/d = (√(5d^2 -2d +1)+d-1) / (2d)$. Letting $d$ tend to $+∞$, the price-of-hierarchy approaches $(1+√5) / 2$ (the golden ratio).
