#import "preamble.typ": *; #show: preamble

$vec("weight", "profit")$-Instance:
$
  I ≔ lr(size: #50%, [overbrace(#[$vec(2^2 n, 2^2 n), …, vec(2^(n-1)n, 2^(n-1)n)$], I_1),quad overbrace(#[$vec(2n, n),vec(2(n+1), n+1)…,vec(2(2n-1), 2n-1)$], I_2),quad overbrace(vec(2n, 2n), I_3)])
$
Let $J≔[I_1, I_2]$ be the sub-instance obtained by removing the last item from $I$.\
Let $P(I), P(J)$ be the respective pareto-sets.

Consider the subsets of items from $I_1$. The sum of the weights of such subsets covers all numbers in ${4n x | x∈{0,…,2^(n-2)}}$

- Claim: If a packing in $P(J)$ doesn't include all items from $I_1$, it includes at most one item from $I_2$
  - #Green[TODO]
- Conclusion:
  $
    P(J)
    quad=quad {A mid(|) A⊊I_1} med med ∪med med{A ∪ {b} mid(|) A ⊊ I_1, b∈I_2}
    med med∪med med {I_1 ∪ B mid(|) B⊆I_2}
  $
  Because $abs(I_1) = n-2$ and $abs(I_2)=n$, the size of $P(J)$ is is $abs(P(J)) = (2^(n-2)-1)+(2^(n-2) -1)n + 2^n$.
- Due to #Green[some lemma], $P(I)$ is a subset of $P(J) ∪{A∪I_3 mid(|) A ∈ P(J)}$, i.e.:
  $
    P(I)
    quad ⊆ quad & {A     & mid(|) & A⊊I_1} med med & ∪ & med med #Red[${A ∪ {b} &mid(|)& A ⊊ I_1, b∈I_2}$]
                                                         med med & ∪ & med med {I_1 ∪ B       & mid(|) & B⊆I_2} \
              ∪ & {A∪I_3 & mid(|) & A⊊I_1} med med & ∪ & med med #Red[${A ∪ {b} ∪I_3 &mid(|)& A ⊊ I_1, b∈I_2}$]
                                                         med med & ∪ & med med {I_1 ∪ B ∪ I_3 & mid(|) & B⊆I_2}
  $
  However, all packings in the middle #Red[red] sets are dominated by other elements:
  - A packing of the form $A ∪ {b}$, where $A ⊊ I_1$ and $b∈I_2$ is dominated by $A ∪ I_3$, because $vec(2n, 2n)$ (the sole element of $I_3$) has greater profit than every $b ∈ I_2$, but not more weight than any $b ∈ I_2$.
  - A packing of the form $A ∪ {b} ∪I_3$, where $A ⊊ I_1$ and $b∈I_2$, is dominated by #Green[(TODO clean up). This uses a similar argument to the earlier todo: Replace $A$ by a different subset from $I_1$. Specifically, if you represent $A$ as a binary number, increment $A$ by one, and replace it with the corresponding subset $A′$ from $I_1$. Such an $A′$ exists because $A$ does not contain every element from $I_1$. Compared to $A∪{b}∪I_3$, the packing $A′∪{b}∪I_3$ has a $vec("weight", "profit")$-difference of $vec(4n, 4n)$. Thus, by kicking out $b$, we get a dominating packing. In other words, the packing $A′ ∪I_3$ dominates $A∪{b}∪I_3$ because it has lower weight and higher profit.
    ]

  Thus, the red sets are not actually part of $P(I)$. Using this, we can bound the size of $P(I)$:
  $
    abs(P(I))
    quad≤quad (2^(n-2)-1)+(2^n) + (2^(n-2)-1) + (2^n)
    quad=quad 2^(n+1) + 2^(n-1) + 2.
  $
- Thus, $P(J) = O(n 2^n)$, but $P(I) ≤ O(2^n)$, so for the ratio we have $P(J)/P(I) ≥ O(n)$.
