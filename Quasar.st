"暫定実装。
QubitはリストモナドのBag版。
Universeはブロックのラッパー。
ブラックホールはMaybeのNothing。
DarkMatterはUndefinedObject(生成すらできない)。
ParallelWorldはただのBag(多分変わる)。
QuantumComputerはParallelWorldを実行する。
TimemachineはUniverseのslice"


Bag subclass: #Qubit
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!

!Qubit methodsFor: 'binding' stamp: 'MinoriYamashita 11/5/2012 00:29'!
bind: blk
  "BlockClosure -> Qubit"
  ^ Qubit unit: (self collect:blk)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Qubit class
instanceVariableNames: ''!

!Qubit class methodsFor: 'instance creation' stamp: 'MinoriYamashita 11/5/2012 00:23'!
unit: raw
  ^ super new add:raw! !


UndefinedObject subclass: #DarkMatter
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!


Bag subclass: #ParallelWorld
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!


Object subclass: #QuantumComputer
instanceVariableNames: 'universes'
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!

!QuantumComputer methodsFor: 'accessing' stamp: 'MinoriYamashita 11/5/2012 00:03'!
universes: univs
  "Bag(Universe) -> self"
  universes := univs! !


!QuantumComputer methodsFor: 'evaluating' stamp: 'MinoriYamashita 11/5/2012 01:22'!
value: x
  "a -> Bag(a)"
  "apply a value to each universe"
  ^ universes collect:[:universe|
    universe value:x]! !


Object subclass: #Timemachine
instanceVariableNames: 'universe'
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!

!Timemachine methodsFor: 'time traveling' stamp: 'MinoriYamashita 11/5/2012 00:49'!
backTo: n
  ^ universe at:n! !


!Timemachine methodsFor: 'as yet unclassified' stamp: 'MinoriYamashita 11/5/2012 01:21'!
universe:unv
  universe := unv! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Timemachine class
instanceVariableNames: ''!

!Timemachine class methodsFor: 'instance creation' stamp: 'MinoriYamashita 11/5/2012 00:46'!
newFor: anUniverse
  ^ super new universe:anUniverse! !


Object subclass: #Universe
instanceVariableNames: 'eras universe'
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!

!Universe methodsFor: 'evaluating' stamp: 'MinoriYamashita 11/4/2012 23:35'!
value: x
  "a -> a"
  "apply universe a value"
  ^ universe value:x! !


!Universe methodsFor: 'accessing' stamp: 'MinoriYamashita 11/5/2012 00:50'!
at: anIndex
  eras at:anIndex! !

!Universe methodsFor: 'accessing' stamp: 'MinoriYamashita 11/4/2012 23:35'!
eras: eraColl
  "OrderedCollection(BlockClosure) -> self"
  "save a collection of blocks for timemachines"
  eras := eraColl ! !

!Universe methodsFor: 'accessing' stamp: 'MinoriYamashita 11/4/2012 23:35'!
universe: unv
   "BlockClosure -> self"
   "universe is a wrapped block"
   universe := unv! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Universe class
instanceVariableNames: ''!

!Universe class methodsFor: 'instance creation' stamp: 'MinoriYamashita 11/5/2012 00:43'!
newWithEras: eraColl |univ recur|
  "OrderedCollection(BlockClosure) -> Universe"
  "Form one block from multiple blocks"
  univ := super new.
  univ eras:eraColl.
  
  recur := [:blks|
    blks size = 1 ifTrue: [blks first]
      ifFalse: [
[:x| (recur value:(blks allButFirst)) value:(blks first value:x)]]].

  univ universe: (recur value:eraColl).

  ^ univ! !


Object subclass: #Blackhole
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: 'Quasar'!

!Blackhole methodsFor: 'evaluating' stamp: 'MinoriYamashita 11/4/2012 23:39'!
value: x
  "ignore value and return self"! !
