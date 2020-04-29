from pysat.solvers import Glucose3
from operator import or_, and_, neg
from functools import reduce
import sys

n = int(input())
ss = list(map(int, input().split()))
ts = list(map(int, input().split()))
us = list(map(int, input().split()))
vs = list(map(int, input().split()))

ans = [0] * (n * n)

for bit in range(64):
    solver = Glucose3()

    for direction, (ops, results) in enumerate([[ss, us], [ts, vs]]):
        for i, (op, result) in enumerate(zip(ops, results)):
            if direction == 0:
                vals = [i * n + j + 1 for j in range(n)]
            else:
                vals = [j * n + i + 1 for j in range(n)]

            if op == 0:
                if (result >> bit) & 1 == 0:
                    solver.add_clause(list(map(neg, vals)))
                else:
                    for val in vals:
                        solver.add_clause([val])
            else:
                if (result >> bit) & 1 == 0:
                    for val in vals:
                        solver.add_clause([-val])
                else:
                    solver.add_clause(vals)

    print("Solving bit {}...".format(bit), file=sys.stderr)

    if solver.solve() == False:
        print(-1)
        sys.exit()
    else:
        model = solver.get_model()
        for value in model:
            if value > 0:
                ans[value - 1] |= 1 << bit

for y in range(n):
    print(' '.join([str(ans[y * n + x]) for x in range(n)]))
