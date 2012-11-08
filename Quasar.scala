object Quasar {

  trait QuasarObject[T] {
    def value(obj: T): Option[T]
  }

  class Universe[T](eras: Array[Function1[T, T]]) {
    val BIG_CRUNCH = (x: T) => x
    val universe = eras.reverse.fold(BIG_CRUNCH)(
				      (nxt, era) => (x => nxt(era(x))))
    def value(obj: T): Option[T] = Some(universe(obj))
  }

  class Blackhole[T] extends QuasarObject[T] {
    def value(obj: T): Option[T] = None
  }

  def main(args: Array[String]) = {
    val universe =
      new Universe[String](Array(
	      x => x + "x",
	      y => y + "y",
	      z => z + "z"))
    println(universe.value("a"))
  }
}
