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

class Blackhole(object):

    def __getattribute__(self, name):
        return self

class DarkMatter(object):
    pass

blackhole = Blackhole()
darkmatter = DarkMatter()

print blackhole.x.y.z
print Universe([ lambda x: x + "x",
                 lambda y: y + "y",
                 lambda z: z + "z"
               ])("a")
