# coding: utf-8
# 途中までしか実装してない(

class Universe(object):

    @staticmethod
    def BIG_CRUNCH(x):
        return x

    def __init__(self, eras):

        self.eras = eras

        def build_universe(eras):
            if len(eras) == 0:
                return Universe.BIG_CRUNCH
            return lambda x: build_universe(eras[1:])(eras[0](x))
        self.universe = build_universe(eras)

    def value(self, x):
        return self.universe(x)

    __call__ = value

class Timemachine(object):

    def __init__(self, universe):
        self.universe = universe

    def back_to(self, at):
        return Universe(self.universe.eras[at:])

class Qubit(object):

    def __init__(self, possibilities):
        self.possibilities = possibilities
    
    def __str__(self):
        return str(self.possibilities)

    def bind(self, fn):
        return Qubit([fn(x) for x in self.possibilities])

class ParallelWorld(list):
    pass

class Blackhole(object):

    def __getattribute__(self, name):
        return self

class DarkMatter(object):
    pass

blackhole = Blackhole()
darkmatter = DarkMatter()

class QuantumComputer(object):

    def __init__(self, pallalel_world):
        self.pallalel_world = pallalel_world

    def value(self, x = blackhole):
        return [universe.value(blackhole) for universe in self.pallalel_world]

    __call__ = value

anUniverse = Universe([ lambda x: x + "x",
                 lambda y: y + "y",
                 lambda z: z + "z"
               ])
print anUniverse("a") # axyz

timemachine = Timemachine(anUniverse)
print timemachine.back_to(1)("a") # ayz

qubit = Qubit([1,2,3,4,5])
print qubit.bind(lambda x: x + 1)

aParalelWorld = ParallelWorld([ Universe([lambda x: 1]),
                                Universe([lambda x: 2]),
                                Universe([lambda x: 3]),
                                ])
qc = QuantumComputer(aParalelWorld)
print qc()
print blackhole.x.y.z
