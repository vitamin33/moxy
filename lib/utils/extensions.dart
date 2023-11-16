extension Let<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}

extension StatusCodeExtensions on int {
  bool isSuccessful() {
    return this >= 200 && this < 300;
  }
}

extension CurrencyExtensions on int {
  int convertToPenny() {
    return this * 100;
  }
}

extension MapIndexed on Iterable {
  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }
}
