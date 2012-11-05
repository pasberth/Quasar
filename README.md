Quasar
=========

program multiverse

いろんな言語で謎ライブラリとして作りたい。

Multiverse
----------
ユーザーがプログラムを書くトップレベルのことを`Multiverse`と呼称する。  
このなかに複数の`Universe`が存在することになるため。


Universe
--------
`Univers`eは1引数のクロージャを複数合成したもの.

###Era
Universeのコンストラクタにはクロージャの順序付きコレクションを与えるが、
このクロージャ一つ一つの事を`anEra`(時代)と呼称する。(これはラッパーを作った方がいいかも)

```javascript
var anUniverse;

anUniverse = new Universe([
  function (x) { return x; } //first era
  , function (y) { return y + 1; } //second era
  , function (z) { return z + 2 ;} //last era
]);

"これはUniverseの内部で"

function (x) {
  return (function (y) {
    return (function (z) {
      return z + 2; //big crunch
    })(y + 1);
  })(x);
};

"になる"
```

`anUniverse`(Universeのインスタンス)は`value(a)`っていうメソッドを持ってて、これを呼ぶと内部の合成された関数が評価される。

###Big Crunch
anUniverseは評価されると、一つずつ`時代`を下って行き、最後の`時代`のreturnで`Big Crunch`を迎える。  
anUniverseは死ぬ時に値を残すと考えていい。

Timemachine
-----------
`Timemachine`は`Universe`を`slice`して、任意の時代からやり直しが出来る。
ある宇宙が失敗したらタイムマシンで過去に戻って、違う値を与えてみるとか。ほむほむまじほむほむ。

```javascript
var timemachine;
timemachine = Timemachine new(anUniverse);
timemachine.backTo(1); //-> Universe(function (y) { return (function (z) { return z + 2; })(y+1); })
```

Qubit
-----
`Qubit`は量子ビットのこと。重ね合わせの状態を表現する。
実体は可能性のコレクションのモナド。Bagのようなコレクションが望ましい。

```javascript
var qubit;
qubit = new Qubit([1,2,3,4,5]);
qubit.bind(function (possibility) { return possibility + 1; }); //-> Qubit(2,3,4,5,6)
```

ParallelWorld
-------------
複数のUniverseの集合。これもBag型のコレクションがもともとある言語ではこれを使う事が望ましい。
今は単なるBagだが、いずれ宇宙レンジの機能もこれに内包したい。

Universe Range
--------------
宇宙レンジは高階宇宙。宇宙を返す関数。今はクラスではなく概念。

QuantumComputer
---------------
量子コンピュータは`aPararellWorld`の中のそれぞれの`Universe`を個別に評価し、
全ての宇宙での結果をまとめて、統計に便利なメソッドを持ったコンテナに包んで返す。

```javascript
aParallelWorld = new ParallelWorld([
  new Universe([function (x) {return 1;}]),
  new Universe([function (x) {return 2;}]),
  new Universe([function (x) {return 3;}])
]);
new QuantumComputer(aParallelWorld); //->Bag(1, 2, 3)
```

Blackhole
---------
ブラックホールはMaybeモナドのNothingに近い。valueメソッドを持ち、何を与えられても何もせずselfを返す。

```javascript
new Blackhole().value(1).value(2).value(3).value(4) //-> Blackhole
```

他にもかっこいい名前のかっこいい機能を思いついたらissuesに気軽に書き込んでください。