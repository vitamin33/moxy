extension Let<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}

extension StatusCodeExtensions on int {
  bool isSuccessful() {
    return this >= 200 && this < 300;
  }
}
