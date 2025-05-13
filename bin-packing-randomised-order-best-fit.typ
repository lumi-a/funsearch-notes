#import "preamble.typ": *; #show: preamble
#import "@preview/ctheorems:1.1.3": *
#show: thmrules

#let OPT = math.op("OPT")
#set heading(numbering: "1.")

#let theorem = thmbox("theorem", "Theorem", fill: blue.lighten(87.5%)).with(numbering: none)
#let proof = thmproof("proof", "Proof")

#set outline.entry(fill: line(length: 100%, stroke: black.lighten(50%)))
#outline()

#v(2em)


= Notation

I follow the notation from @bin_packing_revisited. Each bin has capacity $1$. For a bin-packing instance $I$ and a permutation $σ$, let $𝒜(I^σ)$ be the number of bins that the best-fit algorithm uses, and $OPT(I)$ the minimum number of bins. Define the *absolute random order ratio* and the *asymptotic random order ratio* of best-fit:
$
  R R &≔ &&sup_(I) {(𝔼_(σ)[𝒜(I^σ)]) / OPT(I) }\
  R R^∞ &≔ limsup_(k→∞) thick &&sup_(I) {(𝔼_(σ)[𝒜(I^σ)]) / OPT(I) mid(|) OPT(I)=k}\
$

In @bin_packing_revisited #Green[(Which seems to have the most up-to-date results?)], they cite and prove that:
$
  1.30 ≤ R R ≤ 1.5,
  quad
  1.1 < R R^∞ #Green[$≤ 1.5$]
$
#Green[(The green inequality isn't mentioned in the paper, but it should follow trivially from the upper-bound for $R R$, unless I'm making some terrible mistake?)].

= The absolute random order ratio is exactly $1.5$
I won't be making progress on $R R^∞$, but I hope I can prove the following:
#theorem()[
  $R R = 1.5$.
]
#proof[
  We need to show $R R ≥ 1.5$. For this, we will define a sequence of instances for which the random-order-ratio converges to $1.5$. For some $n∈ℕ_(≥1)$, define the instance:
  $
    I ≔ lr(size: #50%, [underbrace(1 / n\, …\, 1 / n, n "times"),quad underbrace(1 / (n+1)\, …\, 1 / (n+1), (n+1) "times")]),
  $
  and remember that each bin has capacity $1$.

  An optimal solution is to assign the first $n$ items to one bin, and the remaining $(n+1)$ items to another bin. This uses two bins, and the sum of all the items (an upper bound on the optimum solution) is $2$.

  We will now show that this is the _only_ optimum solution.
  - If there is a bin that is not perfectly-filled, i.e. the sum of its contained items is strictly less than $1$, then the packing requires at least $3$ bins: The sum of all items is $2$, but at least one of the bin wastes space.
  - So all bins must be perfectly-filled. Assume there existed a perfectly-filled bin containing mixed items, i.e. containing $a ⋅ 1 / n$ and $b ⋅ 1 / (n+1)$, with $a∈{1,…,n-1}$ and $b∈{1,…,n}$. This is equivalent to:
    $
      a / n + b / (n+1) = 1
      quad⟺quad
      a (n+1) + b n = n(n+1)
      quad ⟺ quad
      n (b+a-n) =n-a
    $
    The left-hand-side is a multiple of $n$, but (because $a∈{1,…,n-1}$) the right-hand-side must be in ${1,…,n-1}$, which is a contradiction. So there are no perfectly-filled bin containing a mix of the items $1 / n$ and $1 / (n+1)$.

  So (up to re-labeling bins) there is only one optimal solution. Consider a permutation of $I$ where best-fit finds the optimal solution.
  - If the first item is $1 / n$, then the next $(n-1)$ items must be $1 / n$ as well, as otherwise the first bin would contain a mix of items. For a random permutation that has $1 / n$ as its first item, the probability of this happening is #Green[at most $2^(1-n)$, and this bound loses a _lot_, but writing down the exact bound is not instructive for the proof. I might add the exact bound later.]
  - If the first item is $1 / (n+1)$, then the next $(n-1)$ items must be $1 / (n+1)$ as well, as otherwise the first bin would contain a mix of items. For a random permutation that has $1 / (n-1)$ as its first item, the probability of this happening #Green[at most $2^(1-n)$, see note above.]

  Altogether, the probability that the algorithm finds the optimal solution is bounded by $2^(1-n)$. Its expected number of bins is thus bounded by:
  $
    𝔼_σ [𝒜(I^σ)]
    quad≥quad 2⋅(2^(1-n)) + 3⋅(1-2^(1-n))
    quad=quad 3 - 2^(1-n).
  $
  Letting $n→∞$, its expected number of bins is $≥3$, while the optimal solution always uses $2$ bins.
]

= I can't easily extend the proof to the asymptotic case
Instead of the instance:
$
  lr(size: #50%, [underbrace(1 / n\, …\, 1 / n, n "times"),quad underbrace(1 / (n+1)\, …\, 1 / (n+1), (n+1) "times")]),
$
one could, more generally, use coprime positive integers $a,b$ and define:
$
  lr(size: #50%, [underbrace(1 / a\, …\, 1 / a, a "times"),quad underbrace(1 / b\, …\, 1 / b, b "times")]),
$
I believe that, for large $a,b$, best-fit would almost-always need $3$ bins, as well, though the proof turned out to be too irritating, so I constrained myself to $b=a+1$.

I also had the idea to expand this to more than just two numbers, with hopes of this proving something about $R R^∞$. If we have a set of numbers $n_1,…,n_k$ such that every pair is coprime (e.g. a finite subset of #link("https://en.wikipedia.org/wiki/Sylvester%27s_sequence")[Sylvester's Sequence]), we could define:
$
  lr(size: #50%, [underbrace(1 / n_1\, …\, 1 / n_1, n_1 "times"),quad…,quad underbrace(1 / (n_k)\, …\, 1 / (n_k), n_k "times")]),
$
Similar to the other instances, the optimum value is $k$, and there is only one optimal solution. However, best-fit does not tend to use $(3) / 2 k$ bins, but rather around $k+1$ bins (tested empirically). Unimpressively, this shows that $R R^∞ ≥ lim_(k→∞) (k+1) / k = 1$.


= How FunSearch found this instance
#show raw.where(block: true): code => {
  figure(block(fill: gray.lighten(87.5%), inset: 1em, stroke: 0.125em + gray, radius: 1em, code))
}
The highest-performing function found by FunSearch was:
#figure(
  ```py
  def get_items() -> list[float]:
    """Return a new bin-packing-instance, specified by the list of items.

    The items must be floats between 0 and 1."""
    """Yet another version of `get_items_v0`, `get_items_v1`, and `get_items_v2`, with some lines altered."""
    items = [0.8, 0.2, 0.6, 0.4]
    # Split the first item into seven smaller items and the fourth item into five smaller items
    items = [0.114, 0.114, 0.114, 0.114, 0.114, 0.114, 0.114] + items[1:3] + [0.08, 0.08, 0.08, 0.08, 0.08]
    return items
  ```,
  caption: [Approximation-ratio $≈1.49811$],
)
Cleaning this up a bit (in python, multiplying a list by a number produces a repeated list, e.g. `[1,2]*2 == [1,2,1,2]`):
#figure(
  ```py
  def get_items() -> list[float]:
    return [0.8 / 7]*7 + [0.2, 0.6] + [0.4 / 5]*5
  ```,
  caption: [Approximation-ratio $≈1.49807$],
)
I noticed that $0.8+0.2=1.0$ and $0.6+0.4=1.0$, so I tried different pairs that sum to $1.0$, and these turned out to work great:
#figure(
  ```py
  def get_items() -> list[float]:
    return [0.99 / 7]*7 + [0.01, 0.02] + [0.98 / 5]*5
  ```,
  caption: [Approximation-ratio $≈1.49867$],
)
After thinking about potential proofs, I considered that the `0.01, 0.02` might just be redundant, which was correct:
#figure(
  ```py
  def get_items() -> list[float]:
    a = 7
    b = 5
    return [1.0 / a]*a + [1.0 / b]*b
  ```,
  caption: [Approximation-ratio $≈1.495531$],
)
The approximation-ratio decreased, but it was still extremely close to $1.5$, and the structure was cleaner now. Trying out different values for `a` and `b` indicated that coprime pairs maintained high approximation-ratios. This was enough to come up with a sketch for the proof.




#bibliography("bibliography.bib")

