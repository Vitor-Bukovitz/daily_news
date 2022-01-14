abstract class Either<L, R> {
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Either<L, R>;
  }
}

class Right<L, R> extends Either<L, R> {
  final R _value;
  Right(this._value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_value);
}

class Left<L, R> extends Either<L, R> {
  final L _value;
  Left(this._value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_value);
}
