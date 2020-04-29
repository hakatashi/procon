from z3 import *
from operator import or_, and_
from functools import reduce

n = int(input())
ss = list(map(int, input().split()))
ts = list(map(int, input().split()))
us = list(map(int, input().split()))
vs = list(map(int, input().split()))

solver = Solver()
cs = [BitVec("c{}".format(i), 64) for i in range(n * n)]

for direction, (ops, results) in enumerate([[ss, us], [ts, vs]]):
    for i, (op, result) in enumerate(zip(ops, results)):
        if direction == 0:
            row = [cs[i * n + j] for j in range(n)]
        else:
            row = [cs[j * n + i] for j in range(n)]
        solver.add(reduce(and_ if op == 0 else or_, row) == result)

if solver.check() == unsat:
    print(-1)
else:
    model = solver.model()
    for y in range(n):
        print(' '.join([str(model[cs[y * n + x]]) for x in range(n)]))
