"use strict";

var Qubit, Universe, Blackhole, DarkMatter, ParallelWorld, QuantumComputer, Timemachine;

Qubit = function (possibilities) {
  this.possibilities = possibilities;
};
Qubit.prototype.bind = function (fn) {
  return new Qubit(this.possibilities.map(function (p) {
    return fn(p);
  }));
};
Qubit.prototype.value = function () {
  return this.possibilities;
};
Qubit.prototype.toString = function () {
  return "[object Qubit]";
};

Universe = function (blks) {
  var recur;
  if (blks.length < 0) throw "bigcrunch";
  this.eras = blks;

  recur = function (blks) {
    if (blks.length === 1) return blks[0];
    return function (x) {
      return recur(blks.slice(1))(blks[0](x))
    }
  };
  this.universe = recur(blks);
};
Universe.prototype.at = function (idx) {
  return new Universe(this.eras.slice(idx));
};
Universe.prototype.value = function (val) {
  return this.universe(val);
};
Universe.prototype.toString = function () {
  return "[object Universe]";
};


Blackhole = function () {
};
Blackhole.prototype.value = function (x) {
  return this;
};
Blackhole.prototype.toString = function () {
  return "[object Blackhole]";
};

DarkMatter = function () {};
DarkMatter.prototype.toString = function () {
  return "[object DarkMatter]";
};

ParallelWorld = Array;

QuantumComputer = function (universes) {
  this.universes = universes;
};
QuantumComputer.prototype.value = function (x) {
  "This will be wrapped in a useful class in the future"
  return this.universes.map(function (univ) {
    return univ.value(x);
  });
};
QuantumComputer.prototype.toString = function () {
  return "[object QuantumComputer]";
};

Timemachine = function (universe) {
  this.universe = universe;
};
Timemachine.prototype.backTo = function (idx) {
  return this.universe.at(idx);
};
Timemachine.prototype.toString = function () {
  return "[object Timemachine]";
};


(function () {
  console.log('should be:8 actually:'+
    new Timemachine(new Universe([
      function (x) {return x+1;}
      , function (x) {return x+2;}
      , function (x) {return x+3;}
    ])).backTo(1).value(3)
  );

  var parallel = function (possibility) {
    return new Universe([
      function (x) {return possibility},
      function (x) {return x + 1}
    ]);
  };
  var parallelWorlds = new Qubit([1,2,3,4]).bind(function (p) {return parallel(p)}).value();
  var quantumComputer = new QuantumComputer(parallelWorlds);
  console.log('should be:2,3,4,5 actually:'+
    quantumComputer.value(null)
  );

  console.log('should be:[object Blackhole] actually:'+
    new Blackhole().value(2).value(3).value(4).toString()
  );
}());
