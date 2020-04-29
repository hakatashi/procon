from z3 import *
from operator import or_, and_
from functools import reduce
import sys

n = int(input())
ss = list(map(int, input().split()))
ts = list(map(int, input().split()))
us = list(map(int, input().split()))
vs = list(map(int, input().split()))

ans = [0] * (n * n)

for bit in range(64):
    solver = Solver()
    cs = [BitVec("c{}".format(i), n) for i in range(n)]

    for i, (op, result) in enumerate(zip(ss, map(lambda v: (v >> bit) & 1, us))):
        if op == 0:
            if result == 0:
                solver.add(cs[i] != (1 << n) - 1)
            else:
                solver.add(cs[i] == (1 << n) - 1)
        else:
            if result == 0:
                solver.add(cs[i] == 0)
            else:
                solver.add(cs[i] != 0)

    and_mask = 0
    and_result = 0
    or_mask = 0
    or_result = 0
    for i, (op, result) in enumerate(zip(ts, map(lambda v: (v >> bit) & 1, vs))):
        if op == 0:
            and_mask |= 1 << i
            if result == 1:
                and_result |= 1 << i
        else:
            or_mask |= 1 << i
            if result == 1:
                or_result |= 1 << i

    solver.add(reduce(and_, cs) & and_mask == and_result)
    solver.add(reduce(or_, cs) & or_mask == or_result)

    print("Solving bit {}...".format(bit), file=sys.stderr)

    if solver.check() == unsat:
        print(-1)
        sys.exit()
    else:
        model = solver.model()
        for y in range(n):
            c = model[cs[y]].as_long()
            for x in range(n):
                if (c >> x) & 1 == 1:
                    ans[y * n + x] |= 1 << bit

for y in range(n):
    print(' '.join([str(ans[y * n + x]) for x in range(n)]))
