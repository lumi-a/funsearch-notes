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
- #Green[TODO: Find upper bound for $|P(I)|$.]
